# frozen_string_literal: true

module ERBLint
  module Linters
    module Helpers
      # Helpers to share between DeprecatedComponents ERB lint and Rubocop cop
      module DeprecatedComponentsHelpers
        # If there is no alternative to suggest, set the value to nil
        COMPONENT_TO_USE_INSTEAD = {
          "Primer::DetailsComponent" => "Primer::Beta::Details",
          "Primer::Alpha::AutoComplete::Item" => "Primer::Beta::AutoComplete::Item",
          "Primer::Alpha::AutoComplete" => "Primer::Beta::AutoComplete",
          "Primer::BlankslateComponent" => "Primer::Beta::Blankslate",
          "Primer::BorderBoxComponent" => "Primer::Beta::BorderBox",
          "Primer::BoxComponent" => "Primer::Box",
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
          @deprecated_components ||= statuses_json.select { |_, value| value == "deprecated" }.keys
        end
      end
    end
  end
end
