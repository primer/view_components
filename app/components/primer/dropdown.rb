# frozen_string_literal: true

module Primer
  # `Dropdown` is a lightweight context menu for housing navigation and actions.
  # They're great for instances where you don't need the full power (and code) of the SelectMenu.
  class Dropdown < Primer::Component
    # Required trigger for the dropdown. Has the same arguments as <%= link_to_component(Primer::ButtonComponent) %>,
    # but it is locked as a `summary` tag.
    renders_one :button, lambda { |**system_arguments, &block|
      @button_arguments = system_arguments
      @button_arguments[:button] = true
      @button_arguments[:dropdown] = @with_caret

      view_context.capture { block&.call }
    }

    # Required context menu for the dropdown.
    #
    # @param as [Symbol] When `as` is `:list`, wraps the menu in a `<ul>` with a `<li>` for each item.
    # @param direction [Symbol] <%= one_of(Primer::Dropdown::Menu::DIRECTION_OPTIONS) %>
    # @param scheme [Symbol] Pass `:dark` for dark mode theming
    # @param header [String] Optional string to display as the header
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :menu, "Primer::Dropdown::Menu"

    # @example Default
    #   <%= render(Primer::Dropdown.new) do |c| %>
    #     <% c.button do %>
    #       Dropdown
    #     <% end %>
    #
    #     <% c.menu(header: "Options") do |menu|
    #       menu.item { "Item 1" }
    #       menu.item { "Item 2" }
    #       menu.item { "Item 3" }
    #     end %>
    #   <% end %>
    #
    # @example With dividers
    #
    #   @description
    #     Dividers can be used to separate a group of items. They don't have any content.
    #   @code
    #     <%= render(Primer::Dropdown.new) do |c| %>
    #       <% c.button do %>
    #         Dropdown
    #       <% end %>
    #
    #       <% c.menu(header: "Options") do |menu|
    #         menu.item { "Item 1" }
    #         menu.item { "Item 2" }
    #         menu.item(divider: true)
    #         menu.item { "Item 3" }
    #         menu.item { "Item 4" }
    #         menu.item(divider: true)
    #         menu.item { "Item 5" }
    #         menu.item { "Item 6" }
    #       end %>
    #     <% end %>
    #
    # @example With direction
    #   <%= render(Primer::Dropdown.new(display: :inline_block)) do |c| %>
    #     <% c.button do %>
    #       Dropdown
    #     <% end %>
    #
    #     <% c.menu(header: "Options", direction: :s) do |menu|
    #       menu.item { "Item 1" }
    #       menu.item { "Item 2" }
    #       menu.item { "Item 3" }
    #       menu.item { "Item 4" }
    #     end %>
    #   <% end %>
    #
    # @example With caret
    #   <%= render(Primer::Dropdown.new(with_caret: true)) do |c| %>
    #     <% c.button do %>
    #       Dropdown
    #     <% end %>
    #
    #     <% c.menu(header: "Options") do |menu|
    #       menu.item { "Item 1" }
    #       menu.item { "Item 2" }
    #       menu.item { "Item 3" }
    #       menu.item { "Item 4" }
    #     end %>
    #   <% end %>
    #
    # @example Customizing the button
    #   <%= render(Primer::Dropdown.new) do |c| %>
    #     <% c.button(scheme: :primary, variant: :small) do %>
    #       Dropdown
    #     <% end %>
    #
    #     <% c.menu(header: "Options") do |menu|
    #       menu.item { "Item 1" }
    #       menu.item { "Item 2" }
    #       menu.item { "Item 3" }
    #       menu.item { "Item 4" }
    #     end %>
    #   <% end %>
    #
    # @example Menu as list
    #   <%= render(Primer::Dropdown.new) do |c| %>
    #     <% c.button do %>
    #       Dropdown
    #     <% end %>
    #
    #     <% c.menu(as: :list, header: "Options") do |menu|
    #       menu.item { "Item 1" }
    #       menu.item { "Item 2" }
    #       menu.item(divider: true)
    #       menu.item { "Item 3" }
    #       menu.item { "Item 4" }
    #     end %>
    #   <% end %>
    #
    # @example Customizing menu items
    #   <%= render(Primer::Dropdown.new) do |c| %>
    #     <% c.button do %>
    #       Dropdown
    #     <% end %>
    #
    #     <% c.menu(header: "Options") do |menu|
    #       menu.item(tag: :button) { "Item 1" }
    #       menu.item(classes: "custom-class") { "Item 2" }
    #       menu.item { "Item 3" }
    #     end %>
    #   <% end %>
    #
    # @param overlay [Symbol] <%= one_of(Primer::DetailsComponent::OVERLAY_MAPPINGS.keys) %>
    # @param with_caret [Boolean] Whether or not a caret should be rendered in the button.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(overlay: :default, with_caret: false, **system_arguments)
      @with_caret = with_caret

      @system_arguments = system_arguments
      @system_arguments[:overlay] = overlay
      @system_arguments[:reset] = true
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "dropdown"
      )
    end

    def render?
      button.present? && menu.present?
    end
  end
end
