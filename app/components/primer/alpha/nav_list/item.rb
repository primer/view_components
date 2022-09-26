# frozen_string_literal: true

module Primer
  module Alpha
    class NavList
      # Items are rendered as styled links. They can optionally include leading and/or trailing visuals,
      # such as icons, avatars, and counters. Items are selected by ID. IDs can be specified via the
      # `selected_item_ids` argument, which accepts a list of valid IDs for the item. Items can also
      # themselves contain sub items. Sub items are rendered collapsed by default.
      class Item < Primer::Alpha::ActionList::Item
        attr_reader :selected_by_ids, :sub_item

        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Item) %>.
        renders_many :items, lambda { |**system_arguments|
          raise "Items can only be nested 2 levels deep" if sub_item?

          @list.build_item(parent: self, sub_item: true, **system_arguments).tap do |item|
            @list.will_add_item(item)

            if item.active?
              @content_arguments[:classes] = class_names(
                @content_arguments[:classes],
                "ActionListContent--hasActiveSubItem"
              )
            end
          end
        }

        # Whether or not this item is nested under a parent item.
        #
        # @return [Boolean]
        alias sub_item? sub_item

        # @param selected_item_id [Symbol] The ID of the currently selected list item. Used internally.
        # @param selected_by_ids [Array<Symbol>] The list of IDs that select this item. In other words, if the `selected_item_id` attribute on the parent `NavList` is set to one of these IDs, the item will appear selected.
        # @param expanded [Boolean] Whether this item shows (expands) or hides (collapses) its list of sub items.
        # @param sub_item [Boolean] Whether or not this item is nested under a parent item. Used internally.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(selected_item_id: nil, selected_by_ids: [], sub_item: false, expanded: false, **system_arguments)
          @selected_item_id = selected_item_id
          @selected_by_ids = Array(selected_by_ids)
          @expanded = expanded
          @sub_item = sub_item

          system_arguments[:classes] = class_names(
            system_arguments[:classes],
            "ActionListItem--subItem" => @sub_item
          )

          @sub_list_arguments = {
            classes: class_names(
              "ActionList",
              "ActionList--subGroup"
            )
          }

          overrides = { "data-item-id": @selected_by_ids.join(" ") }
          overrides[:active] = @selected_by_ids.include?(@selected_item_id)

          super(**system_arguments, **overrides)
        end

        # Cause this item to show its list of sub items when rendered.
        def expand!
          @expanded = true
        end

        def before_render
          super

          raise "Cannot render a trailing visual for an item with subitems" if items.present? && trailing_visual.present?

          return if items.blank?

          @content_arguments[:tag] = :button
          @content_arguments[:"aria-expanded"] = @expanded.to_s
          @content_arguments[:"data-action"] = "click:#{@list.custom_element_name}#handleItemWithSubItemClick"

          with_private_trailing_action_icon(:"chevron-down", classes: "ActionListItem-collapseIcon")

          @system_arguments[:classes] = class_names(
            @system_arguments[:classes],
            "ActionListItem--hasSubItem"
          )
        end
      end
    end
  end
end
