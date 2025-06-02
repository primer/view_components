# typed: false
# frozen_string_literal: true

module Primer
  module Alpha
    class ActionMenu
      # This component is part of <%= link_to_component(Primer::Alpha::ActionMenu) %> and should not be
      # used as a standalone component.
      class SubMenu < Menu
        DEFAULT_ANCHOR_ALIGN = :start
        DEFAULT_ANCHOR_SIDE = :outside_right

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

        # @param menu_id [String] Id of the menu.
        # @param anchor_align [Symbol] <%= one_of(Primer::Alpha::Overlay::ANCHOR_ALIGN_OPTIONS) %>
        # @param anchor_side [Symbol] <%= one_of(Primer::Alpha::Overlay::ANCHOR_SIDE_OPTIONS) %>
        # @param overlay_arguments [Hash] Arguments to pass to the underlying <%= link_to_component(Primer::Alpha::Overlay) %>
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>.
        def initialize(
          menu_id:,
          anchor_align: DEFAULT_ANCHOR_ALIGN,
          anchor_side: DEFAULT_ANCHOR_SIDE,
          overlay_arguments: {},
          **system_arguments
        )
          overlay_arguments[:anchor] = "#{menu_id}-button"
          super
        end

        # Adds a sub-menu to the menu.
        #
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionMenu::SubMenuItem) %>.
        def with_sub_menu_item(**system_arguments, &block)
          super(
            anchor_align: anchor_align, # carry over to sub-menus
            anchor_side: anchor_side, # carry over to sub-menus
            **system_arguments,
            &block
          )
        end
      end
    end
  end
end
