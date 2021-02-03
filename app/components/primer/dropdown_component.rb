# frozen_string_literal: true

module Primer
  # DropdownMenus are lightweight context menus for housing navigation and actions.
  # They're great for instances where you don't need the full power (and code)
  # of the select menu.
  class DropdownMenuComponent < Primer::Component
    include ViewComponent::SlotableV2

    renders_one :button
    renders_one :menu, Primer::DropdownMenuComponent

    # @example 200|Default
    #   <div style="margin-bottom: 150px">
    #     <%= render(Primer::DropdownComponent.new(overlay: :default, reset: true, position: :relative)) do |c| %>
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
    # @param overlay [Symbol] <%= one_of(Primer::DetailsComponent::OVERLAY_MAPPINGS.keys) %>
    # @param reset [Boolean] Whether to hide the default caret on the button
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(overlay: :default, reset: true, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:overlay] = overlay
      @system_arguments[:reset] = :reset
      @system_arguments[:position] = :relative
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "dropdown",
      )
    end
  end
end
