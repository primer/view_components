# frozen_string_literal: true

module Primer
  module Alpha
    # :nodoc:
    class NavList < ActionList
      def initialize(selected_item_id: nil, **system_arguments)
        @system_arguments = system_arguments
        @selected_item_id = selected_item_id

        aria_label = aria(:label, system_arguments)
        raise ArgumentError, "an aria-label is required" if aria_label.nil?

        super(tag: :nav, **@system_arguments)
      end

      def build_item(component_klass: NavList::Item, **system_arguments)
        component_klass.new(
          **system_arguments,
          selected_item_id: @selected_item_id,
          list: self
        )
      end

      def build_list(**system_arguments)
        NavList.new(
          **system_arguments,
          selected_item_id: @selected_item_id
        )
      end

      def will_add_item(item)
        item.parent.expand! if item.active? && item.parent
      end
    end
  end
end
