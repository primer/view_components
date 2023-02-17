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
      # Button to activate the menu. This may be a <%= link_to_component(Primer::ButtonComponent) %> or <%= link_to_component(Primer::IconButton) %>.
      #
      # @param icon [Symbol] Set this to an [Octicon name](https://primer.style/octicons/) when you want to render an `IconButton`. Otherwise, this renders as a <%= link_to_component(Primer::ButtonComponent) %>.
      renders_one :trigger, lambda { |icon: nil, **system_arguments|
        if icon
          Primer::Beta::IconButton.new(scheme: :invisible, role: "button", icon: icon, "aria-haspopup": true, "aria-expanded": false, "aria-controls": list_id, id: menu_id, **system_arguments)
        else
          Primer::Beta::Button.new(scheme: :default, role: "button", "aria-haspopup": true, "aria-controls": list_id, "aria-expanded": false, id: menu_id, **system_arguments)
        end
      }

      # <%= link_to_component(Primer::Alpha::ActionMenu::Item) %>
      renders_many :items, lambda { |**system_arguments|
        Primer::Alpha::ActionMenu::Item.new(select_variant: @select_variant, **system_arguments)
      }

      ANCHOR_ALIGN_DEFAULT = :start
      ANCHOR_ALIGN_OPTIONS = [ANCHOR_ALIGN_DEFAULT, :center, :end].freeze

      ANCHOR_SIDE_DEFAULT = :outside_bottom
      ANCHOR_SIDE_OPTIONS = [:outside_top, ANCHOR_SIDE_DEFAULT, :outside_left, :outside_right].freeze

      DEFAULT_PRELOAD = false

      DEFAULT_SELECT_VARIANT = :none
      SELECT_VARIANT_OPTIONS = [
        :single,
        :multiple,
        DEFAULT_SELECT_VARIANT
      ].freeze

      # @example Default
      #  <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-0") do |c| %>
      #    <% c.with_trigger { "Menu" } %>
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
      #    <% c.with_trigger(with_caret: true) { "Menu" } %>
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
      #      <% c.with_trigger(icon: :"kebab-horizontal", "aria-label": "Menu") %>
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
      #    <% c.with_trigger(icon: :"kebab-horizontal", "aria-label": "Menu") %>
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
      #    <% c.with_trigger(icon: :"kebab-horizontal", "aria-label": "Menu") %>
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
      #       <% c.with_trigger(with_caret: true) { "Outside top" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-6", anchor_align: :center, anchor_side: :outside_left) do |c| %>
      #       <% c.with_trigger(with_caret: true) { "Outside left" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::Alpha.new(menu_id: "my-action-menu-7", anchor_align: :center, anchor_side: :outside_right) do |c| %>
      #       <% c.with_trigger(with_caret: true) { "Outside right" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-8", anchor_align: :center, anchor_side: :outside_bottom) do |c| %>
      #       <% c.with_trigger(with_caret: true) { "Outside bottom" } %>
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
      #       <% c.with_trigger(with_caret: true) { "Outside top" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-10", anchor_align: :start, anchor_side: :outside_left) do |c| %>
      #       <% c.with_trigger(with_caret: true) { "Outside left" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-11", anchor_align: :start, anchor_side: :outside_right) do |c| %>
      #       <% c.with_trigger(with_caret: true) { "Outside right" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-12", anchor_align: :start, anchor_side: :outside_bottom) do |c| %>
      #       <% c.with_trigger(with_caret: true) { "Outside bottom" } %>
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
      #       <% c.with_trigger(with_caret: true) { "Outside top" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-14", anchor_align: :end, anchor_side: :outside_left) do |c| %>
      #       <% c.with_trigger(with_caret: true) { "Outside left" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-15", anchor_align: :end, anchor_side: :outside_right) do |c| %>
      #       <% c.with_trigger(with_caret: true) { "Outside right" } %>
      #       <% c.with_item do %>
      #         Item 1 that does something
      #       <% end %>
      #       <% c.with_item do %>
      #         Item 2 that does another thing
      #       <% end %>
      #     <% end %>
      #     <%= render Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-16", anchor_align: :end, anchor_side: :outside_bottom) do |c| %>
      #       <% c.with_trigger(with_caret: true) { "Outside bottom" } %>
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
      #    <% c.with_trigger(icon: :"kebab-horizontal", "aria-label": "Menu") %>
      #  <% end %>
      #
      # @param menu_id [String] Id of the menu.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      # @param anchor_align [Symbol] <%= one_of(Primer::Alpha::ActionMenu::ANCHOR_ALIGN_OPTIONS) %>
      # @param anchor_side [Symbol] <%= one_of(Primer::Alpha::ActionMenu::ANCHOR_SIDE_OPTIONS) %>
      # @param src [String] Used with an `include-fragment` element to load menu content from the given source URL.
      # @param preload [Boolean] When true, and src is present, loads the `include-fragment` on trigger hover.
      def initialize(
        menu_id:,
        anchor_align: ANCHOR_ALIGN_DEFAULT,
        anchor_side: ANCHOR_SIDE_DEFAULT,
        src: nil,
        preload: DEFAULT_PRELOAD,
        select_variant: DEFAULT_SELECT_VARIANT,
        **system_arguments
      )
        @menu_id = menu_id
        @src = src
        @preload = fetch_or_fallback_boolean(preload, DEFAULT_PRELOAD)
        @select_variant = fetch_or_fallback(SELECT_VARIANT_OPTIONS, select_variant, DEFAULT_SELECT_VARIANT)
        @system_arguments = deny_tag_argument(**system_arguments)

        @system_arguments[:preload] = true if @src.present? && @preload == true

        @system_arguments[:tag] = :"action-menu"
        @system_arguments[:"data-anchor-align"] = fetch_or_fallback(ANCHOR_ALIGN_OPTIONS, anchor_align, ANCHOR_ALIGN_DEFAULT).to_s
        @system_arguments[:"data-anchor-side"] = fetch_or_fallback(ANCHOR_SIDE_OPTIONS, anchor_side, ANCHOR_SIDE_DEFAULT).to_s.dasherize
        @system_arguments[:"data-select-variant"] = @select_variant
      end

      private

      def before_render
        raise ArgumentError, "you cannot use `items` when `src` is specified" if @src.present? && items.any?
      end

      def menu_id
        "#{@menu_id}-text"
      end

      def list_id
        "#{@menu_id}-list"
      end

      def render?
        items.any? || @src.present?
      end
    end
  end
end
