# frozen_string_literal: true

module ERBLint
  module Linters
    module Helpers
      # Helpers to share between DeprecatedComponents ERB lint and Rubocop cop
      module DeprecatedComponentsHelpers
        # If there is no alternative to suggest, set the value to nil
        COMPONENT_TO_USE_INSTEAD = {
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
          @deprecated_components ||= statuses_json.select { |_, value| value == "deprecated" }.keys.tap do |deprecated_components|
            deprecated_components.each do |deprecated|
              unless COMPONENT_TO_USE_INSTEAD.key?(deprecated)
                raise "Please provide a component that should be used in place of #{deprecated} in COMPONENT_TO_USE_INSTEAD. "\
                      "If there is no alternative, set the value to nil."
              end
            end
          end
        end
      end
    end
  end
end
