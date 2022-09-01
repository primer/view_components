# frozen_string_literal: true

module Primer
  module Alpha
    class NavList
      # :nodoc:
      class Item < Primer::Alpha::ActionList::Item
        def initialize(selected_item_id: nil, selected_by_ids: [], **system_arguments)
          @selected_item_id = selected_item_id
          @selected_by_ids = Array(selected_by_ids)

          overrides = { select_mode: :none, "data-item-id": @selected_by_ids.join(" ") }
          overrides[:active] = true if @selected_by_ids.include?(@selected_item_id)
        	# overrides[private_leading_action(icon: :"chevron-down")]

          super(**system_arguments, **overrides)
        end

        # def before_render
				# 	self.private_leading_action(icon: :"chevron-down")
				# end
      end
    end
  end
end
