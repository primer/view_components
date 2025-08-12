# typed: false
# frozen_string_literal: true

module Primer
  module Alpha
    class ActionMenu
      # This component is part of <%= link_to_component(Primer::Alpha::ActionMenu) %> and should not be
      # used as a standalone component.
      class Menu < Primer::Component
        DEFAULT_PRELOAD = false

        DEFAULT_SELECT_VARIANT = :none
        SELECT_VARIANT_OPTIONS = [
          :single,
          :multiple,
          DEFAULT_SELECT_VARIANT
        ].freeze

        attr_reader :menu_id, :anchor_side, :anchor_align, :list, :preload, :src, :select_variant, :form_arguments

        delegate :with_item, :with_avatar_item, :with_divider, :with_group, :items, :acts_as_form_input?, to: :@list

        alias preload? preload

        # @!parse
        #   # Adds an item to the menu.
        #   #
        #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList) %>'s `item` slot.
        #   def with_item(**system_arguments)
        #   end
        #
        #   # Adds an avatar item to the menu.
        #   #
        #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList) %>'s `item` slot.
        #   def with_avatar_item(**system_arguments)
        #   end
        #
        #   # Adds a divider to the list. Dividers visually separate items.
        #   #
        #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Divider) %>.
        #   def with_divider(**system_arguments)
        #   end
        #
        #   # Adds a group to the menu. Groups are a logical set of items with a header.
        #   #
        #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionMenu::Group) %>.
        #   def with_group(**system_arguments)
        #   end
        #
        #   # Gets the list of configured menu items, which includes regular items, avatar items, groups, and dividers.
        #   #
        #   # @return [Array<ViewComponent::Slot>]
        #   def items
        #   end

        # @param anchor_align [Symbol] <%= one_of(Primer::Alpha::Overlay::ANCHOR_ALIGN_OPTIONS) %>
        # @param anchor_side [Symbol] <%= one_of(Primer::Alpha::Overlay::ANCHOR_SIDE_OPTIONS) %>
        # @param menu_id [String] Id of the menu.
        # @param size [Symbol] <%= one_of(Primer::Alpha::Overlay::SIZE_OPTIONS) %>
        # @param src [String] Used with an `include-fragment` element to load menu content from the given source URL.
        # @param preload [Boolean] When true, and src is present, loads the `include-fragment` on trigger hover.
        # @param select_variant [Symbol] <%= one_of(Primer::Alpha::ActionMenu::Menu::SELECT_VARIANT_OPTIONS) %>
        # @param form_arguments [Hash] Allows an `ActionMenu` to act as a select list in multi- and single-select modes. Pass the `builder:` and `name:` options to this hash. `builder:` should be an instance of `ActionView::Helpers::FormBuilder`, which are created by the standard Rails `#form_with` and `#form_for` helpers. The `name:` option is the desired name of the field that will be included in the params sent to the server on form submission.
        # @param overlay_arguments [Hash] Arguments to pass to the underlying <%= link_to_component(Primer::Alpha::Overlay) %>
        # @param list_arguments [Hash] Arguments to pass to the underlying <%= link_to_component(Primer::Alpha::ActionMenu::List) %>
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>.
        def initialize(
          anchor_align:,
          anchor_side:,
          menu_id: self.class.generate_id,
          size: Primer::Alpha::Overlay::DEFAULT_SIZE,
          src: nil,
          preload: DEFAULT_PRELOAD,
          select_variant: DEFAULT_SELECT_VARIANT,
          form_arguments: {},
          overlay_arguments: {},
          list_arguments: {},
          **system_arguments
        )
          @menu_id = menu_id
          @src = src
          @preload = fetch_or_fallback_boolean(preload, DEFAULT_PRELOAD)
          @anchor_side = anchor_side
          @anchor_align = anchor_align

          @select_variant = fetch_or_fallback(SELECT_VARIANT_OPTIONS, select_variant, DEFAULT_SELECT_VARIANT)
          @form_arguments = form_arguments

          overlay_arguments[:data] = merge_data(
            overlay_arguments, data: {
              target: "action-menu.overlay"
            }
          )

          @overlay = Primer::Alpha::Overlay.new(
            id: "#{@menu_id}-overlay",
            title: "Menu",
            visually_hide_title: true,
            anchor_align: anchor_align,
            anchor_side: anchor_side,
            size: size,
            **overlay_arguments
          )

          @list = Primer::Alpha::ActionMenu::List.new(
            menu_id: @menu_id,
            select_variant: select_variant,
            form_arguments: form_arguments,
            **list_arguments
          )

          system_arguments # rubocop:disable Lint/Void
        end

        # Adds a sub-menu to the menu.
        #
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionMenu::SubMenuItem) %>.
        def with_sub_menu_item(**system_arguments, &block)
          @list.with_item(
            component_klass: SubMenuItem,
            select_variant: select_variant,
            form_arguments: form_arguments,
            **system_arguments,
            &block
          )
        end

        private

        def before_render
          raise ArgumentError, "`items` cannot be set when `src` is specified" if src.present? && items.any?
        end
      end
    end
  end
end
