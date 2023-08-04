# frozen_string_literal: true

module Primer
  module Alpha
    class AutoComplete
      # Use `AutoCompleteItem` to list results of an auto-completed search.
      class Item < Primer::Component
        status :deprecated

        # @param value [String] Value of the item.
        # @param selected [Boolean] Whether the item is selected.
        # @param disabled [Boolean] Whether the item is disabled.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(value:, selected: false, disabled: false, **system_arguments)
          @system_arguments = deny_tag_argument(**system_arguments)
          @system_arguments[:tag] = :li
          @system_arguments[:role] = :option
          @system_arguments[:"data-autocomplete-value"] = value
          @system_arguments[:"aria-selected"] = true if selected
          @system_arguments[:"aria-disabled"] = true if disabled
          @system_arguments[:classes] = class_names(
            "autocomplete-item",
            system_arguments[:classes],
            "disabled" => disabled
          )
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) { content }
        end
      end
    end
  end
end
