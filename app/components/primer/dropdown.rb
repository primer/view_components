# frozen_string_literal: true

module Primer
  # `Dropdown` is a lightweight context menu for housing navigation and actions.
  # They're great for instances where you don't need the full power (and code) of the select menu.
  class Dropdown < Primer::Component
    # Required trigger for the dropdown. Has the same arguments as <%= link_to_component(Primer::ButtonComponent) %>,
    # but it is locked as a `summary` tag.
    renders_one :summary, lambda { |**system_arguments, &block|
      @summary_arguments = system_arguments
      @summary_arguments[:button] = true

      view_context.capture { block&.call }
    }

    # Required context menu for the dropdown
    #
    # @param as [Symbol] When `as` is `:list`, wraps the menu in a `<ul>` with a `<li>` for each item.
    # @param direction [Symbol] <%= one_of(Primer::Dropdown::Menu::DIRECTION_OPTIONS) %>
    # @param scheme [Symbol] Pass `:dark` for dark mode theming
    # @param header [String] Optional string to display as the header
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :menu, "Primer::Dropdown::Menu"

    # @example Default
    #   <div>
    #     <%= render(Primer::Dropdown.new) do |c| %>
    #       <% c.summary do %>
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
    # @example With Direction
    #   <div>
    #     <%= render(Primer::Dropdown.new(display: :inline_block)) do |c| %>
    #       <% c.summary do %>
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
    # @example Customizing the button
    #   <div>
    #     <%= render(Primer::Dropdown.new) do |c| %>
    #       <% c.summary(scheme: :primary, variant: :small) do %>
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
    # @example Menu as list
    #   <div>
    #     <%= render(Primer::Dropdown.new) do |c| %>
    #       <% c.summary do %>
    #         Dropdown
    #       <% end %>
    #
    #       <%= c.menu(as: :list, header: "Options") do |menu|
    #         menu.item { "Item 1" }
    #         menu.item { "Item 2" }
    #         menu.item(divider: true)
    #         menu.item { "Item 3" }
    #         menu.item { "Item 4" }
    #       end %>
    #     <% end %>
    #   </div>
    #
    # @example Customizing menu items
    #   <div>
    #     <%= render(Primer::Dropdown.new) do |c| %>
    #       <% c.summary do %>
    #         Dropdown
    #       <% end %>
    #
    #       <%= c.menu(header: "Options") do |menu|
    #         menu.item(tag: :summary) { "Item 1" }
    #         menu.item(tag: :button) { "Item 2" }
    #         menu.item(divider: true)
    #         menu.item(classes: "custom-class") { "Item 3" }
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
      @system_arguments[:reset] = reset
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "dropdown"
      )
    end

    def render?
      summary.present? && menu.present?
    end
  end
end
