# frozen_string_literal: true

module Primer
  module Alpha
    class NavList
      # Items are rendered as styled links. They can optionally include leading and/or trailing visuals,
      # such as icons, avatars, and counters. Items are selected by ID. IDs can be specified via the
      # `selected_item_ids` argument, which accepts a list of valid IDs for the item. Items can also
      # themselves contain sub lists. Sub lists are rendered collapsed by default.
      class Item < Primer::Alpha::ActionList::Item
        attr_reader :selected_by_ids

        # @param selected_item_id [Symbol]
        def initialize(selected_item_id: nil, selected_by_ids: [], **system_arguments)
          @selected_item_id = selected_item_id
          @selected_by_ids = Array(selected_by_ids)

          overrides = { "data-item-id": @selected_by_ids.join(" ") }
          overrides[:active] = true if @selected_by_ids.include?(@selected_item_id)

          super(**system_arguments, **overrides)
        end
      end
    end
  end
end
