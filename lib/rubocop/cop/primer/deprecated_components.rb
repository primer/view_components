# frozen_string_literal: true

require "rubocop"
require "json"
require "parser/current"
require_relative "../../../primer/view_components/linters/helpers/deprecated_components_helpers"

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
        include ERBLint::Linters::Helpers::DeprecatedComponentsHelpers

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
      end
    end
  end
end
