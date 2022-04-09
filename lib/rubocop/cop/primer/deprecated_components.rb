# frozen_string_literal: true

require "rubocop"
require "json"
require 'parser/current'

module RuboCop
  module Cop
    module Primer
      # This cop ensures that components marked as "deprecated" in `static/statuses.json` are not used.
      class DeprecatedComponents < BaseCop
        # Converts a string to acceptable rubocop-ast pattern syntax
        def pattern(component)
          Parser::CurrentRuby.parse(component)
            .to_s
            .gsub('nil', 'nil?')
            .gsub("\n", "")
            .gsub("  ", " ")
        end

        # If there is no alternative, set the value to nil.
        ALTERNATIVE_COMPONENTS = {
          "Primer::BlankslateComponent" => "Primer::Beta::Blankslate",
          "Primer::DropdownMenuComponent" => nil,
          "Primer::Tooltip" => "Primer::Alpha::Tooltip",
          "Primer::FlexComponent" => nil,
          "Primer::FlexItemComponent" => nil
        }.freeze

        def on_send(node)
          load_deprecated_components
          @deprecated_components.each do |component|
            pattern = "(send #{pattern(component)} :new ...)"
            add_offense(node, message: message(component))  if NodePattern.new(pattern).match(node)
          end
        end

        def message(component)
          message = "#{component} has been deprecated and should not be used."
          if ALTERNATIVE_COMPONENTS.fetch(component).present?
            message += " Please use #{ALTERNATIVE_COMPONENTS[component]} instead." 
          end
          message
        end

        def load_deprecated_components
          json = JSON.parse(
            File.read(
              File.join(File.dirname(__FILE__), "../../../../static/statuses.json")
            )
          ).freeze
          @deprecated_components = json.select { |_, value| value == "deprecated" }.keys
          @deprecated_components.each do |deprecated|
            unless ALTERNATIVE_COMPONENTS.keys.include?(deprecated)
              raise "Please add an alternative component for #{deprecated} to ALTERNATIVE_COMPONENTS. If none exist, set the value to nil."
            end
          end
        end
      end
    end
  end
end
