# frozen_string_literal: true

require "rubocop"
require "json"

module RuboCop
  module Cop
    module Primer
      # This cop ensures that components with deprecated status are not used.
      # When an alternative component is available, it should be added to the ALTERNATIVE_COMPONENTS
      # so that it can be suggested.
      class DeprecatedComponents < BaseCop
        ALTERNATIVE_COMPONENTS = {
          "Primer::LayoutComponent" => "Primer::Alpha::Layout",
          "Primer::Tooltip" => "Primer::Alpha::Tooltip",
          "Primer::BlankslateComponent" => "Primer::Beta::Blankslate"
        }

        def on_send(node)
          load_deprecated_components
          # Todo - find match with `@deprecated_components``
          # save match to `component` variable
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
              File.join(File.dirname(__FILE__), "../../../../static/statuses.json")
            )
          ).freeze
          @deprecated_components = json.select {|key, value| value == 'deprecated'}.keys
        end
      end
    end
  end
end
