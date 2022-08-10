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

      def build_item(selected_by_ids: [], **system_arguments)
        selected_by_ids = Array(selected_by_ids)

        overrides = { select_mode: :none, "data-item-id": selected_by_ids.join(" ") }

        if selected_by_ids.include?(@selected_item_id)
          overrides[:active] = true
        end

        super(**system_arguments, **overrides, list: self)
      end

      def will_add_item(item)
        item.root.expand! if item.active? && item.root
      end
    end
  end
end
