# frozen_string_literal: true

module Primer
  module Alpha
    # The ActionMenu should be used when a user can select a single option from a list of items, usually one that triggers an action.
    #
    # @accessibility
    #  TODO
    class ActionMenu < Primer::Component
      # Button to activate the menu. This may be a <%= link_to_component(Primer::ButtonComponent) %> or <%= link_to_component(Primer::IconButton) %>.
      #
      # @param icon [Symbol] Set this to an [Octicon name](https://primer.style/octicons/) when you want to render an `IconButton`. Otherwise, this renders as a <%= link_to_component(Primer::ButtonComponent) %>.
      # @param with_caret [Boolean] Whether to include a caret. Always `false` when `icon:` is set.
      renders_one :trigger, lambda { |icon: nil, with_caret: false, **system_arguments|
        if icon
          Primer::IconButton.new(icon: icon, "aria-haspopup": true, "aria-expanded": false, "aria-controls": "#{@menu_id}-list", id: @menu_id, **system_arguments)
        else
          Primer::ButtonComponent.new(dropdown: with_caret, "aria-haspopup": true, "aria-controls": "#{@menu_id}-list", "aria-expanded": false, id: @menu_id, **system_arguments)
        end
      }

      renders_many :items, "Item"

      # @example Default
      #  <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-0") do |c| %>
      #    <%= c.trigger { "Menu" } %>
      #    <% c.item { "Quote" } %>
      #    <% c.item { "Edit" } %>
      #    <% c.item { "Delete" } %>
      #  <% end %>
      #
      # @example With caret
      #  <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-1") do |c| %>
      #    <%= c.trigger(with_caret: true) { "Menu" } %>
      #    <% c.item { "Quote" } %>
      #    <% c.item { "Edit" } %>
      #    <% c.item { "Delete" } %>
      #  <% end %>
      #
      # @example With `IconOnly` trigger
      #   @description
      #     Set `icon:` to the octicon you want to use. Always provide an accessible name for the menu by setting `aria-label`.
      #   @code
      #    <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-2") do |c| %>
      #      <%= c.trigger(icon: :"kebab-horizontal", "aria-label": "Menu") %>
      #      <% c.item { "Quote reply" } %>
      #      <% c.item { "Edit" } %>
      #      <% c.item { "Delete" } %>
      #    <% end %>
      #
      # @example With divider
      #  <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-3") do |c| %>
      #    <%= c.trigger(icon: :"kebab-horizontal", "aria-label": "Menu") %>
      #    <% c.item { "Quote reply" } %>
      #    <% c.item { "Edit" } %>
      #    <% c.item(is_divider: true) %>
      #   <% c.item { "Delete" } %>
      #  <% end %>
      #
      # @example With interactive children
      #   @description
      #     TO DO: what children are allowed? Links, buttons...?
      #   @code
      #    <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-2") do |c| %>
      #      <%= c.trigger(icon: :"kebab-horizontal", "aria-label": "Menu") %>
      #      <% c.item do %>
      #        <a href="https://primer.style/design/">Primer Design</a>
      #      <% end %>
      #      <% c.item do %>
      #        <a href="https://primer.style/view-components/">Primer ViewComponents</a>
      #      <% end %>
      #      <% c.item do %>
      #        <a href="https://primer.style/react/">Primer React</a>
      #      <% end %>
      #    <% end %>
      #
      # @param menu_id [String] Id of the menu.
      # @param menu_text [String] Text for the menu button.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(menu_id:, **system_arguments)
        @menu_id = menu_id
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :"primer-action-menu"
      end

      def render?
        items.any?
      end

      # This component is part of `Primer::Alpha::ActionMenu` and should not be
      # used as a standalone component.
      class Item < Primer::Component
        def initialize(is_divider: false, **system_arguments)
          @is_divider = is_divider
          @system_arguments = deny_tag_argument(**system_arguments)
          @system_arguments[:tag] = :li

          if @is_divider
            @system_arguments[:"aria-hidden"] = "true"
            @system_arguments[:classes] = "dropdown-divider"
          else
            @system_arguments[:classes] = "dropdown-item"
            @system_arguments[:role] = "menuitem"
            @system_arguments[:tabindex] = -1
          end
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) { content }
        end
      end
    end
  end
end
