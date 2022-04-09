# frozen_string_literal: true

require "rubocop"
require "json"

module RuboCop
  module Cop
    module Primer
      # This cop ensures that components with deprecated status are not used.
      # When an alternative is available, it should be added to the ALTERNATIVE_COMPONENTS map.
      class DeprecatedComponents < BaseCop
        def_node_matcher :legacy_component?, <<~PATTERN
          (send (const (const nil? :Primer) :LayoutComponent) :new ...)
        PATTERN

        ALTERNATIVE_COMPONENTS = {
          "Primer::LayoutComponent" => "Primer::Alpha::Layout",
          "Primer::Tooltip" => "Primer::Alpha::Tooltip",
          "Primer::BlankslateComponent" => "Primer::Beta::Blankslate"
        }

        def on_send(node)
          load_deprecated_components
          return unless legacy_component?(node)

          add_offense(node, message: message(component))
        end


        def message(component)
          message = "#{component} has been deprecated."
          if ALTERNATIVE_COMPONENTS.key?(component)
            message += "Please try #{ALTERNATIVE_COMPONENTS[component]} instead."
          end

          message
        end

        def load_deprecated_components
          json = JSON.parse(
            File.read(
              File.join(File.dirname(__FILE__), "../../../static/statuses.json")
            )
          ).freeze
          json.select {|key, value| value == 'deprecated'}
          @deprecated_components = json.fetch_keys
        end
      end
    end
  end
end
