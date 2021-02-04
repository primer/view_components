# frozen_string_literal: true

module Primer
  # DropdownMenus are lightweight context menus for housing navigation and actions.
  # They're great for instances where you don't need the full power (and code)
  # of the select menu.
  class DropdownComponent < Primer::Component
    include ViewComponent::SlotableV2

    renders_one :button
    renders_one :menu, "Primer::DropdownMenuComponent"

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
        "dropdown",
      )
      @summary_classes = summary_classes
    end
  end
end
