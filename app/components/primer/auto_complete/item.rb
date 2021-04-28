# frozen_string_literal: true

module Primer
  class AutoComplete
    # Use AutoCompleteItem to list results of an auto-completed search.
    class Item < Primer::Component
      status :beta

      DEFAULT_TAG = :li

      # @example Default
      #   <%= render(Primer::AutoComplete::Item.new(selected: true, value: "value")) do |c| %>
      #     Selected
      #   <% end %>
      #   <%= render(Primer::AutoComplete::Item.new(value: "value")) do |c| %>
      #     Not selected
      #   <% end %>
      #
      # @param value [String] Value of the item.
      # @param selected [Boolean] Whether the item is selected.
      # @param disabled [Boolean] Whether the item is disabled.
      # @param tag [Symbol] (<%= pretty_value(Primer::AutoComplete::Item::DEFAULT_TAG) %>) <%= locked_tag_text %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(value:, selected: false, disabled: false, **system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = DEFAULT_TAG
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
