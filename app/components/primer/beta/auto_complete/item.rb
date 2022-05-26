# frozen_string_literal: true

# TODO: use generic ActionList item for Autocomplete
module Primer
  module Beta
    class AutoComplete
      # Use `AutoCompleteItem` to list results of an auto-completed search.
      class Item < Primer::Component
        include ViewComponent::PolymorphicSlots
        status :beta

        # @example Default
        #   <%= render(Primer::Beta::AutoComplete::Item.new(selected: true, value: "value")) do |c| %>
        #     Selected
        #   <% end %>
        #   <%= render(Primer::Beta::AutoComplete::Item.new(value: "value")) do |c| %>
        #     Not selected
        #   <% end %>
        #
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
            "ActionList-item",
            system_arguments[:classes]
          )
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) do
            render(Primer::BaseComponent.new(tag: :span, classes: "ActionList-content")) do
              render(Primer::BaseComponent.new(tag: :span, classes: "ActionList-item-label")) { content }
            end
          end
        end
      end
    end
  end
end
