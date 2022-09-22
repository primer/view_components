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

        # @param selected_item_id [Symbol] The ID of the currently selected list item. Used internally.
        # @param selected_by_ids [Array<Symbol>] The list of IDs that select this item. In other words, if the `selected_item_id` attribute on the parent `NavList` is set to one of these IDs, the item will appear selected.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(selected_item_id: nil, selected_by_ids: [], **system_arguments)
          @selected_item_id = selected_item_id
          @selected_by_ids = Array(selected_by_ids)

          overrides = { "data-item-id": @selected_by_ids.join(" ") }
          overrides[:active] = @selected_by_ids.include?(@selected_item_id)

          super(**system_arguments, **overrides)
        end
      end
    end
  end
end
