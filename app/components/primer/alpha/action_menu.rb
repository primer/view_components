# typed: false
# frozen_string_literal: true

module Primer
  module Alpha
    # ActionMenu is used for actions, navigation, to display secondary options, or single/multi select lists. They appear when users interact with buttons, actions, or other controls.
    #
    # The only allowed elements for the `Item` components are: `:a`, `:button`, and `:clipboard-copy`. The default is `:button`.
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

      # @param menu_id [String] Id of the menu.
      # @param anchor_align [Symbol] <%= one_of(Primer::Alpha::Overlay::ANCHOR_ALIGN_OPTIONS) %>.
      # @param anchor_side [Symbol] <%= one_of(Primer::Alpha::Overlay::ANCHOR_SIDE_OPTIONS) %>.
      # @param size [Symbol] <%= one_of(Primer::Alpha::Overlay::SIZE_OPTIONS) %>.
      # @param src [String] Used with an `include-fragment` element to load menu content from the given source URL.
      # @param preload [Boolean] When true, and src is present, loads the `include-fragment` on trigger hover.
      # @param dynamic_label [Boolean] Whether or not to display the text of the currently selected item in the show button.
      # @param dynamic_label_prefix [String] If provided, the prefix is prepended to the dynamic label and displayed in the show button.
      # @param select_variant [Symbol] <%= one_of(Primer::Alpha::ActionMenu::SELECT_VARIANT_OPTIONS) %>
      # @param form_arguments [Hash] Allows an `ActionMenu` to act as a select list in multi- and single-select modes. Pass the `builder:` and `name:` options to this hash. `builder:` should be an instance of `ActionView::Helpers::FormBuilder`, which are created by the standard Rails `#form_with` and `#form_for` helpers. The `name:` option is the desired name of the field that will be included in the params sent to the server on form submission.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>.
      def initialize(
        menu_id: self.class.generate_id,
        anchor_align: Primer::Alpha::Overlay::DEFAULT_ANCHOR_ALIGN,
        anchor_side: Primer::Alpha::Overlay::DEFAULT_ANCHOR_SIDE,
        size: Primer::Alpha::Overlay::DEFAULT_SIZE,
        src: nil,
        preload: DEFAULT_PRELOAD,
        dynamic_label: false,
        dynamic_label_prefix: nil,
        select_variant: DEFAULT_SELECT_VARIANT,
        form_arguments: {},
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
          anchor_side: anchor_side,
          size: size
        )

        @list = Primer::Alpha::ActionMenu::List.new(
          menu_id: @menu_id,
          select_variant: select_variant,
          form_arguments: form_arguments
        )
      end

      # @!parse
      #   # Button to activate the menu.
      #   #
      #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::Overlay) %>'s `show_button` slot.
      #   renders_one(:show_button)

      # Button to activate the menu.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::Overlay) %>'s `show_button` slot.
      def with_show_button(**system_arguments, &block)
        @overlay.with_show_button(**system_arguments, id: "#{@menu_id}-button", controls: "#{@menu_id}-list", &block)
      end

      # @!parse
      #   # Adds a new item to the list.
      #   #
      #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Item) %>.
      #   renders_many(:items)

      # Adds a new item to the list.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Item) %>.
      def with_item(**system_arguments, &block)
        @list.with_item(**system_arguments, &block)
      end

      # Adds a divider to the list.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList) %>'s `divider` slot.
      def with_divider(**system_arguments, &block)
        @list.with_divider(**system_arguments, &block)
      end

      # Adds an avatar item to the list. Avatar items are a convenient way to accessibly add an item with a leading avatar image.
      #
      # @param src [String] The source url of the avatar image.
      # @param username [String] The username associated with the avatar.
      # @param full_name [String] Optional. The user's full name.
      # @param full_name_scheme [Symbol] Optional. How to display the user's full name.
      # @param avatar_arguments [Hash] Optional. The arguments accepted by <%= link_to_component(Primer::Beta::Avatar) %>.
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Item) %>.
      def with_avatar_item(**system_arguments, &block)
        @list.with_avatar_item(**system_arguments, &block)
      end

      private

      def before_render
        content

        raise ArgumentError, "`items` cannot be set when `src` is specified" if @src.present? && @list.items.any?
      end

      def render?
        @list.items.any? || @src.present?
      end
    end
  end
end
