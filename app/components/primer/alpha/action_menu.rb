# typed: false
# frozen_string_literal: true

module Primer
  module Alpha
    # The ActionMenu should be used when a user can select a single option triggering an action from a list of items. Primer will automatically nest an `Item` within a presentational `<li>` tag.
    #
    # The only allowed elements for the `Item` components are: `:a`, `:button`, and `:clipboard-copy`. If one isn't selected, a fallback `:span` will be used. To add functionality, use a `.js` class to create the functionality, or an `onclick` handler.
    #
    # @accessibility
    #   The action for the menu item needs to be on the element with `role="menuitem"`. Semantics are removed for everything nested inside of it. When a menu item is selected, the menu will close immediately.
    #
    #   Additional information around the keyboard functionality and implementation can be found on the [WAI-ARIA Authoring Practices](https://www.w3.org/TR/wai-aria-practices-1.2/#menu).
    class ActionMenu < Primer::Component
      status :alpha

      DEFAULT_PRELOAD = false

      DEFAULT_SELECT_VARIANT = :none
      SELECT_VARIANT_OPTIONS = [
        :single,
        :multiple,
        DEFAULT_SELECT_VARIANT
      ].freeze

      attr_reader :list, :preload

      alias preload? preload

      # @example Default
      #  <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-0") do |c| %>
      #    <% c.with_show_button { "Menu" } %>
      #    <% c.with_item(tag: :a, href: "https://primer.style/design/") do %>
      #      Primer Design
      #    <% end %>
      #    <% c.with_item(tag: :button, type: "button", onclick: "() => {}") do %>
      #      Quote Reply
      #    <% end %>
      #    <% c.with_item(tag: :"clipboard-copy", value: "Text to copy") do %>
      #      Copy Text
      #    <% end %>
      #  <% end %>
      #
      # @example With caret
      #  <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-1") do |c| %>
      #    <% c.with_show_button(with_caret: true) { "Menu" } %>
      #    <% c.with_item(tag: :a, href: "https://primer.style/design/") do %>
      #      Primer Design
      #    <% end %>
      #    <% c.with_item(tag: :button, type: "button") do %>
      #      Quote Reply
      #    <% end %>
      #    <% c.with_item(tag: :"clipboard-copy", value: "Text to copy") do %>
      #      Copy Text
      #    <% end %>
      #  <% end %>
      #
      # @example With `IconButton` trigger
      #   @description
      #     Set `icon:` to the octicon you want to use. Always provide an accessible name for the menu by setting `aria-label`.
      #   @code
      #    <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-2") do |c| %>
      #      <% c.with_show_button(icon: :"kebab-horizontal", "aria-label": "Menu") %>
      #      <% c.with_item(tag: :a, href: "https://primer.style/design/") do %>
      #        Primer Design Link
      #      <% end %>
      #      <% c.with_item(tag: :button, type: "button") do %>
      #        Quote Reply
      #      <% end %>
      #      <% c.with_item(tag: :"clipboard-copy", value: "Text to copy") do %>
      #        Copy Text
      #      <% end %>
      #    <% end %>
      #
      # @example With divider
      #  <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-3") do |c| %>
      #    <% c.with_show_button(icon: :"kebab-horizontal", "aria-label": "Menu") %>
      #    <% c.with_item(tag: :a, href: "https://primer.style/design/") do %>
      #      Primer Design Link
      #    <% end %>
      #    <% c.with_item(tag: :button, type: "button") do %>
      #      Quote Reply
      #    <% end %>
      #    <% c.with_item(is_divider: true) %>
      #    <% c.with_item(tag: :"clipboard-copy", value: "Text to copy") do %>
      #      Copy Text
      #    <% end %>
      #  <% end %>
      #
      # @example With danger item
      #  <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-4") do |c| %>
      #    <% c.with_show_button(icon: :"kebab-horizontal", "aria-label": "Menu") %>
      #    <% c.with_item(tag: :a, href: "https://primer.style/design/") do %>
      #      Primer Design Link
      #    <% end %>
      #    <% c.with_item(tag: :button, type: "button") do %>
      #      Quote Reply
      #    <% end %>
      #    <% c.with_item(tag: :"clipboard-copy", value: "Text to copy") do %>
      #      Copy Text
      #    <% end %>
      #    <% c.with_item(tag: :button, type: "button", is_dangerous: true) do %>
      #      Delete
      #    <% end %>
      #  <% end %>
      #
      # @example With center align
      #   @description
      #     Align the menu to the center of the trigger button
      #   @code
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-5", anchor_align: :center, anchor_side: :outside_top) do |c| %>
      #       <% c.with_show_button(with_caret: true) { "Outside top" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-6", anchor_align: :center, anchor_side: :outside_left) do |c| %>
      #       <% c.with_show_button(with_caret: true) { "Outside left" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::Alpha.new(menu_id: "my-action-menu-7", anchor_align: :center, anchor_side: :outside_right) do |c| %>
      #       <% c.with_show_button(with_caret: true) { "Outside right" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-8", anchor_align: :center, anchor_side: :outside_bottom) do |c| %>
      #       <% c.with_show_button(with_caret: true) { "Outside bottom" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #
      # @example With start align
      #   @description
      #     Align the menu to the start of the trigger button
      #   @code
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-9", anchor_align: :start, anchor_side: :outside_top) do |c| %>
      #       <% c.with_show_button(with_caret: true) { "Outside top" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-10", anchor_align: :start, anchor_side: :outside_left) do |c| %>
      #       <% c.with_show_button(with_caret: true) { "Outside left" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-11", anchor_align: :start, anchor_side: :outside_right) do |c| %>
      #       <% c.with_show_button(with_caret: true) { "Outside right" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-12", anchor_align: :start, anchor_side: :outside_bottom) do |c| %>
      #       <% c.with_show_button(with_caret: true) { "Outside bottom" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #
      # @example With end align
      #   @description
      #     Align the menu to the end of the trigger button
      #   @code
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-13", anchor_align: :end, anchor_side: :outside_top) do |c| %>
      #       <% c.with_show_button(with_caret: true) { "Outside top" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-14", anchor_align: :end, anchor_side: :outside_left) do |c| %>
      #       <% c.with_show_button(with_caret: true) { "Outside left" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-15", anchor_align: :end, anchor_side: :outside_right) do |c| %>
      #       <% c.with_show_button(with_caret: true) { "Outside right" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-16", anchor_align: :end, anchor_side: :outside_bottom) do |c| %>
      #       <% c.with_show_button(with_caret: true) { "Outside bottom" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #
      # @example With deferred menu content loaded with an `include-fragment`
      #  <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-3", src: "/") do |c| %>
      #    <% c.with_show_button(icon: :"kebab-horizontal", "aria-label": "Menu") %>
      #  <% end %>
      #
      # @param menu_id [String] Id of the menu.
      # @param anchor_align [Symbol] <%= one_of(Primer::Alpha::Overlay::ANCHOR_ALIGN_OPTIONS) %>.
      # @param anchor_side [Symbol] <%= one_of(Primer::Alpha::Overlay::ANCHOR_SIDE_OPTIONS) %>.
      # @param src [String] Used with an `include-fragment` element to load menu content from the given source URL.
      # @param preload [Boolean] When true, and src is present, loads the `include-fragment` on trigger hover.
      # @param dynamic_label [Boolean] Whether or not to display the text of the currently selected item in the show button.
      # @param dynamic_label_prefix [String] If provided, the prefix is prepended to the dynamic label and displayed in the show button.
      # @param select_variant [Symbol]. <%= one_of(Primer::Alpha::ActionMenu::SELECT_VARIANT_OPTIONS) %>.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>.
      def initialize(
        menu_id: self.class.generate_id,
        anchor_align: Primer::Alpha::Overlay::DEFAULT_ANCHOR_ALIGN,
        anchor_side: Primer::Alpha::Overlay::DEFAULT_ANCHOR_SIDE,
        src: nil,
        preload: DEFAULT_PRELOAD,
        dynamic_label: false,
        dynamic_label_prefix: nil,
        select_variant: DEFAULT_SELECT_VARIANT,
        **system_arguments
      )
        @menu_id = menu_id
        @src = src
        @preload = fetch_or_fallback_boolean(preload, DEFAULT_PRELOAD)
        @system_arguments = deny_tag_argument(**system_arguments)

        @system_arguments[:preload] = true if @src.present? && preload?

        select_variant = fetch_or_fallback(SELECT_VARIANT_OPTIONS, select_variant, DEFAULT_SELECT_VARIANT)

        @system_arguments[:tag] = :"action-menu"
        @system_arguments[:"data-select-variant"] = select_variant
        @system_arguments[:"data-dynamic-label"] = "" if dynamic_label
        @system_arguments[:"data-dynamic-label-prefix"] = dynamic_label_prefix if dynamic_label_prefix.present?

        @overlay = Primer::Alpha::Overlay.new(
          id: "#{@menu_id}-overlay",
          title: "Menu",
          visually_hide_title: true,
          anchor_align: anchor_align,
          anchor_side: anchor_side
        )

        @list = Primer::Alpha::ActionMenu::List.new(
          menu_id: @menu_id,
          select_variant: select_variant
        )
      end

      # Button to activate the menu. This may be a <%= link_to_component(Primer::ButtonComponent) %> or <%= link_to_component(Primer::IconButton) %>.
      #
      # @param icon [Symbol] Set this to an [Octicon name](https://primer.style/octicons/) when you want to render an `IconButton`. Otherwise, this renders as a <%= link_to_component(Primer::ButtonComponent) %>.
      def with_show_button(**system_arguments, &block)
        @overlay.with_show_button(**system_arguments, id: "#{@menu_id}-button", controls: "#{@menu_id}-list", &block)
      end

      # Adds a new item to the list.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Item) %>.
      def with_item(**system_arguments, &block)
        @list.with_item(**system_arguments, &block)
      end

      # Retrieves the list of items.
      def items
        @list.items
      end

      # Adds a divider to the list.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList) %>'s `divider` slot.
      def with_divider(**system_arguments, &block)
        @list.with_divider(**system_arguments, &block)
      end

      private

      def before_render
        content

        raise ArgumentError, "`items` cannot be set when `src` is specified" if @src.present? && items.any?
      end

      def render?
        items.any? || @src.present?
      end
    end
  end
end
