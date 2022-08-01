# frozen_string_literal: true

module Primer
  module Alpha
    class AutoComplete
      # Use `AutoCompleteItem` to list results of an auto-completed search.
      class Item < Primer::Component
        status :alpha

        # @example Default
        #   <%= render(Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", input_id: "fruits-input--custom-results", list_id: "fruits-popup--custom-results")) do |c| %>
        #     <% c.results(classes: "custom-class") do %>
        #       <%= render(Primer::Alpha::AutoComplete::Item.new(selected: true, value: "apple")) do |c| %>
        #         Apple
        #       <% end %>
        #       <%= render(Primer::Alpha::AutoComplete::Item.new(value: "orange")) do |c| %>
        #         Orange
        #       <% end %>
        #     <% end %>
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
