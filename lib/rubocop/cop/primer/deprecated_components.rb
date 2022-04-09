# frozen_string_literal: true

require "rubocop"
require "json"
require "parser/current"

module RuboCop
  module Cop
    module Primer
      # This cop ensures that components marked as "deprecated" in `static/statuses.json` are discouraged from use.
      #
      # bad
      # Primer::BlankslateComponent.new(:foo)
      #
      # good
      # Primer::Beta::Blankslate.new(:foo)
      #
      # bad
      # Primer::Tooltip.new(:foo)
      #
      # good
      # Primer::Alpha::Tooltip.new(:foo)
      class DeprecatedComponents < BaseCop
        # If there is no alternative to suggest, set the value to nil.
        COMPONENT_TO_USE_INSTEAD = {
          "Primer::BlankslateComponent" => "Primer::Beta::Blankslate",
          "Primer::DropdownMenuComponent" => nil,
          "Primer::Tooltip" => "Primer::Alpha::Tooltip",
          "Primer::FlexComponent" => nil,
          "Primer::FlexItemComponent" => nil
        }.freeze

        def on_send(node)
          return unless node.source.include?("Primer::")

          deprecated_components.each do |component|
            pattern = NodePattern.new("(send #{pattern(component)} :new ...)")
            add_offense(node, message: message(component)) if pattern.match(node)
          end
        end

        private

        # Converts a string to acceptable rubocop-ast pattern syntax
        def pattern(component)
          Parser::CurrentRuby.parse(component)
                             .to_s
                             .gsub("nil", "nil?")
                             .delete("\n")
                             .gsub("  ", " ")
        end

        def message(component)
          message = "#{component} has been deprecated and should not be used."
          message += " Try #{COMPONENT_TO_USE_INSTEAD[component]} instead." if COMPONENT_TO_USE_INSTEAD.fetch(component).present?
          message
        end

        def deprecated_components
          json = JSON.parse(
            File.read(
              File.join(File.dirname(__FILE__), "../../../../static/statuses.json")
            )
          ).freeze
          deprecated_components = json.select { |_, value| value == "deprecated" }.keys
          deprecated_components.each do |deprecated|
            unless COMPONENT_TO_USE_INSTEAD.key?(deprecated)
              raise "Please provide a component that should be used in place of #{deprecated} in COMPONENT_TO_USE_INSTEAD. " +
              "If there is no alternative, set the value to nil."
            end
          end
          deprecated_components
        end
      end
    end
  end
end
