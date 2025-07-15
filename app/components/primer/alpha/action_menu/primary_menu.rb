# typed: false
# frozen_string_literal: true

module Primer
  module Alpha
    class ActionMenu
      # This component is part of <%= link_to_component(Primer::Alpha::ActionMenu) %> and should not be
      # used as a standalone component.
      class PrimaryMenu < Menu
        DEFAULT_ANCHOR_ALIGN = :start
        DEFAULT_ANCHOR_SIDE = :outside_bottom

        attr_reader :dynamic_label, :dynamic_label_prefix

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
        # @param dynamic_label [Boolean] Whether or not to display the text of the currently selected item in the show button.
        # @param dynamic_label_prefix [String] If provided, the prefix is prepended to the dynamic label and displayed in the show button.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>.
        def initialize(
          anchor_align: DEFAULT_ANCHOR_ALIGN,
          anchor_side: DEFAULT_ANCHOR_SIDE,
          dynamic_label: false,
          dynamic_label_prefix: nil,
          **system_arguments
        )
          @dynamic_label = dynamic_label
          @dynamic_label_prefix = dynamic_label_prefix

          system_arguments[:list_arguments] ||= {}

          system_arguments[:list_arguments][:data] = merge_data(
            system_arguments[:list_arguments],
            { data: { target: "action-menu.list" } }
          )

          super(
            anchor_align: anchor_align,
            anchor_side: anchor_side,
            **system_arguments
          )
        end

        # Button to activate the menu.
        #
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::Overlay) %>'s `show_button` slot.
        def with_show_button(**system_arguments, &block)
          @overlay.with_show_button(**system_arguments, id: "#{@menu_id}-button", controls: "#{@menu_id}-list") do |button|
            evaluate_block(button, &block)
          end
        end
      end
    end
  end
end
