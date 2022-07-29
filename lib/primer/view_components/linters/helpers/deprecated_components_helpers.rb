# frozen_string_literal: true

module ERBLint
  module Linters
    module Helpers
      # Helpers to share between DeprecatedComponents ERB lint and Rubocop cop
      module DeprecatedComponentsHelpers
        # If there is no alternative to suggest, set the value to nil
        COMPONENT_TO_USE_INSTEAD = {
          "Primer::Alpha::AutoComplete::Item" => "Primer::Beta::AutoComplete::Item",
          "Primer::Alpha::AutoComplete" => "Primer::Beta::AutoComplete",
          "Primer::BlankslateComponent" => "Primer::Beta::Blankslate",
          "Primer::DropdownMenuComponent" => nil,
          "Primer::Tooltip" => "Primer::Alpha::Tooltip",
          "Primer::FlexComponent" => nil,
          "Primer::FlexItemComponent" => nil
        }.freeze

        def message(component)
          message = "#{component} has been deprecated and should not be used."
          message += " Try #{COMPONENT_TO_USE_INSTEAD[component]} instead." if COMPONENT_TO_USE_INSTEAD.fetch(component).present?
          message
        end

        def statuses_json
          JSON.parse(
            File.read(
              File.join(File.dirname(__FILE__), "../../../../../static/statuses.json")
            )
          ).freeze
        end

        def deprecated_components
          @deprecated_components ||= statuses_json.select { |_, value| value == "deprecated" }.keys.tap do
            if statuses_json.select { |_, value| value == "deprecated" }.keys.sort != COMPONENT_TO_USE_INSTEAD.keys.sort
              raise "Please make sure that components are officially deprecated within the component file and that the deprecated status is reflected in `statuses.json`. "\
              "Each deprecated component in `statuses.json` should have an alternative specified in COMPONENTS_TO_USE_INSTEAD. "\
              "If there is no alternative to suggest, set the value to nil."
            end
          end
        end
      end
    end
  end
end
