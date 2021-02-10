# frozen_string_literal: true

require_relative "dropdown/menu_component"

module Primer
  # Dropdowns are lightweight context menus for housing navigation and actions.
  # They're great for instances where you don't need the full power (and code) of the select menu.
  class DropdownComponent < Primer::Component
    include ViewComponent::SlotableV2

    # Required trigger for the dropdown. Only accepts a content.
    # Its classes can be customized by the `summary_classes` param in the parent component
    renders_one :button

    # Required context menu for the dropdown
    #
    # @param direction [Symbol] <%= one_of(Primer::Dropdown::MenuComponent::DIRECTION_OPTIONS) %>
    # @param scheme [Symbol] Pass :dark for dark mode theming
    # @param header [String] Optional string to display as the header
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :menu, Primer::Dropdown::MenuComponent

    # @example 210|Default
    #   <div style="margin-bottom: 150px">
    #     <%= render(Primer::DropdownComponent.new) do |c| %>
    #       <% c.button do %>
    #         Dropdown
    #       <% end %>
    #
    #       <%= c.menu(header: "Options") do |menu|
    #         menu.item { "Item 1" }
    #         menu.item { "Item 2" }
    #         menu.item(divider: true)
    #         menu.item { "Item 3" }
    #         menu.item { "Item 4" }
    #       end %>
    #     <% end %>
    #   </div>
    #
    # @example 210|With Direction
    #   <div style="margin-bottom: 150px" class="d-flex flex-justify-center">
    #     <%= render(Primer::DropdownComponent.new) do |c| %>
    #       <% c.button do %>
    #         Dropdown
    #       <% end %>
    #
    #       <%= c.menu(header: "Options", direction: :s) do |menu|
    #         menu.item { "Item 1" }
    #         menu.item { "Item 2" }
    #         menu.item(divider: true)
    #         menu.item { "Item 3" }
    #         menu.item { "Item 4" }
    #       end %>
    #     <% end %>
    #   </div>
    #
    # @param overlay [Symbol] <%= one_of(Primer::DetailsComponent::OVERLAY_MAPPINGS.keys) %>
    # @param reset [Boolean] Whether to hide the default caret on the button
    # @param summary_classes [String] Custom classes to add to the button
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(overlay: :default, reset: true, summary_classes: "", **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:overlay] = overlay
      @system_arguments[:reset] = reset
      @system_arguments[:position] = :relative
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "dropdown"
      )
      @summary_classes = summary_classes
    end

    def render?
      button.present? && menu.present?
    end
  end
end
