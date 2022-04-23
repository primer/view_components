# frozen_string_literal: true

module Primer
  module Alpha
    # The ActionMenu should be used when a user can select a single option triggering an action from a list of items. Primer will automatically nest an `Item` within a presentational `<li>` tag. The functionality should live on element with `role="menuitem"`.
    #
    #  The only allowed elements for the `Item` components are `:a`, `:button` and `:clipboard-copy`. We can add to this list if we need more allowed items. To add functionality, use a `.js` class that creates the functionality.
    #
    # @accessibility
    #  When an item has `role="menuitem"`, all other semantics inside of that element are ignored. The action for the menu item needs to be on that element for correct functionality.
    class ActionMenu < Primer::Component
      # Button to activate the menu. This may be a <%= link_to_component(Primer::ButtonComponent) %> or <%= link_to_component(Primer::IconButton) %>.
      #
      # @param icon [Symbol] Set this to an [Octicon name](https://primer.style/octicons/) when you want to render an `IconButton`. Otherwise, this renders as a <%= link_to_component(Primer::ButtonComponent) %>.
      # @param with_caret [Boolean] Whether to include a caret. Always `false` when `icon:` is set.
      renders_one :trigger, lambda { |icon: nil, with_caret: false, **system_arguments|
        if icon
          Primer::IconButton.new(icon: icon, "aria-haspopup": true, "aria-expanded": false, "aria-controls": list_id, id: menu_id, **system_arguments)
        else
          Primer::ButtonComponent.new(dropdown: with_caret, "aria-haspopup": true, "aria-controls": list_id, "aria-expanded": false, id: menu_id, **system_arguments)
        end
      }
      #  <%= link_to_component(Primer::Alpha::ActionMenu::Item) %>
      renders_many :items, "Primer::Alpha::ActionMenu::Item"

      ANCHOR_ALIGN_DEFAULT = :start
      ANCHOR_ALIGN_OPTIONS = [ANCHOR_ALIGN_DEFAULT, :center, :end].freeze

      ANCHOR_SIDE_DEFAULT = :outside_bottom
      ANCHOR_SIDE_OPTIONS = [:outside_top, ANCHOR_SIDE_DEFAULT, :outside_left, :outside_right].freeze

      # @example Default
      #  <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-0") do |c| %>
      #    <%= c.trigger { "Menu" } %>
      #    <% c.item(tag: :a, href: "https://primer.style/design/") do %>
      #      Primer Design
      #    <% end %>
      #    <% c.item(tag: :button, type: "button", classes: "js-do-something") do %>
      #      Button with `.js` class that adds functionality
      #    <% end %>
      #    <% c.item(classes: "js-do-something") do %>
      #      A list item with functionality associated with the class
      #    <% end %>
      #    <% c.item(tag: :"clipboard-copy", value: "Text to copy") do %>
      #      Copy Text
      #    <% end %>
      #  <% end %>
      #
      # @example With caret
      #  <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-1") do |c| %>
      #    <%= c.trigger(with_caret: true) { "Menu" } %>
      #    <% c.item(tag: :a, href: "https://primer.style/design/") do %>
      #      Primer Design
      #    <% end %>
      #    <% c.item(tag: :button, type: "button", classes: "js-do-something") do %>
      #      Button with `.js` class that adds functionality
      #    <% end %>
      #    <% c.item(tag: :"clipboard-copy", value: "Text to copy") do %>
      #      Copy Text
      #    <% end %>
      #  <% end %>
      #
      # @example With `IconButton` trigger
      #   @description
      #     Set `icon:` to the octicon you want to use. Always provide an accessible name for the menu by setting `aria-label`.
      #   @code
      #    <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-2") do |c| %>
      #      <%= c.trigger(icon: :"kebab-horizontal", "aria-label": "Menu") %>
      #      <% c.item(tag: :a, href: "https://primer.style/design/") do %>
      #        Primer Design Link
      #      <% end %>
      #      <% c.item(tag: :button, type: "button", classes: "js-do-something") do %>
      #        Button with `.js` class that adds functionality
      #      <% end %>
      #      <% c.item(tag: :"clipboard-copy", value: "Text to copy") do %>
      #        Copy Text
      #      <% end %>
      #    <% end %>
      #
      # @example With divider
      #  <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-3") do |c| %>
      #    <%= c.trigger(icon: :"kebab-horizontal", "aria-label": "Menu") %>
      #    <% c.item(tag: :a, href: "https://primer.style/design/") do %>
      #      Primer Design Link
      #    <% end %>
      #    <% c.item(tag: :button, type: "button", classes: "js-do-something") do %>
      #      Button with `.js` class that adds functionality
      #    <% end %>
      #    <% c.item(is_divider: true) %>
      #    <% c.item(tag: :"clipboard-copy", value: "Text to copy") do %>
      #      Copy Text
      #    <% end %>
      #  <% end %>
      #
      # @example With danger item
      #  <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-4") do |c| %>
      #    <%= c.trigger(icon: :"kebab-horizontal", "aria-label": "Menu") %>
      #    <% c.item(tag: :a, href: "https://primer.style/design/") do %>
      #      Primer Design Link
      #    <% end %>
      #    <% c.item(tag: :button, type: "button", classes: "js-do-something") do %>
      #      Button with `.js` class that adds functionality
      #    <% end %>
      #    <% c.item(tag: :"clipboard-copy", value: "Text to copy") do %>
      #      Copy Text
      #    <% end %>
      #    <% c.item(tag: :button, type: "button", classes: "js-do-something", is_dangerous: true) do %>
      #      Delete
      #    <% end %>
      #  <% end %>
      #
      # @example With center align
      #   @description
      #     Align the menu to the center of the trigger button
      #   @code
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-5", anchor_align: :center, anchor_side: :outside_top) do |c| %>
      #       <%= c.trigger(with_caret: true) { "Outside top" } %>
      #       <% c.item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-6", anchor_align: :center, anchor_side: :outside_left) do |c| %>
      #       <%= c.trigger(with_caret: true) { "Outside left" } %>
      #       <% c.item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-7", anchor_align: :center, anchor_side: :outside_right) do |c| %>
      #       <%= c.trigger(with_caret: true) { "Outside right" } %>
      #       <% c.item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-8", anchor_align: :center, anchor_side: :outside_bottom) do |c| %>
      #       <%= c.trigger(with_caret: true) { "Outside bottom" } %>
      #       <% c.item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      # @example With start align
      #   @description
      #     Align the menu to the start of the trigger button
      #   @code
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-9", anchor_align: :start, anchor_side: :outside_top) do |c| %>
      #       <%= c.trigger(with_caret: true) { "Outside top" } %>
      #       <% c.item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-10", anchor_align: :start, anchor_side: :outside_left) do |c| %>
      #       <%= c.trigger(with_caret: true) { "Outside left" } %>
      #       <% c.item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-11", anchor_align: :start, anchor_side: :outside_right) do |c| %>
      #       <%= c.trigger(with_caret: true) { "Outside right" } %>
      #       <% c.item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-12", anchor_align: :start, anchor_side: :outside_bottom) do |c| %>
      #       <%= c.trigger(with_caret: true) { "Outside bottom" } %>
      #       <% c.item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      # @example With end align
      #   @description
      #     Align the menu to the end of the trigger button
      #   @code
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-13", anchor_align: :end, anchor_side: :outside_top) do |c| %>
      #       <%= c.trigger(with_caret: true) { "Outside top" } %>
      #       <% c.item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-14", anchor_align: :end, anchor_side: :outside_left) do |c| %>
      #       <%= c.trigger(with_caret: true) { "Outside left" } %>
      #       <% c.item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-15", anchor_align: :end, anchor_side: :outside_right) do |c| %>
      #       <%= c.trigger(with_caret: true) { "Outside right" } %>
      #       <% c.item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-16", anchor_align: :end, anchor_side: :outside_bottom) do |c| %>
      #       <%= c.trigger(with_caret: true) { "Outside bottom" } %>
      #       <% c.item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      # @param menu_id [String] Id of the menu.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      # @param anchor_align [Symbol] <%= one_of(Primer::Alpha::ActionMenu::ANCHOR_ALIGN_OPTIONS) %>
      # @param anchor_side [Symbol] <%= one_of(Primer::Alpha::ActionMenu::ANCHOR_SIDE_OPTIONS) %>
      def initialize(menu_id:, anchor_align: ANCHOR_ALIGN_DEFAULT, anchor_side: ANCHOR_SIDE_DEFAULT, **system_arguments)
        @menu_id = menu_id
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :"action-menu"
        @system_arguments[:"data-anchor-align"] = fetch_or_fallback(ANCHOR_ALIGN_OPTIONS, anchor_align, ANCHOR_ALIGN_DEFAULT).to_s
        @system_arguments[:"data-anchor-side"] = fetch_or_fallback(ANCHOR_SIDE_OPTIONS, anchor_side, ANCHOR_SIDE_DEFAULT).to_s.dasherize
      end

      def menu_id
        "#{@menu_id}-text"
      end

      def list_id
        "#{@menu_id}-list"
      end

      def render?
        items.any?
      end
    end
  end
end
