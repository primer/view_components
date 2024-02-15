# frozen_string_literal: true

module Primer
  module Beta
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

          @list = system_arguments[:list]

          if @list
            @sub_list_arguments["data-action"] = @list.custom_element_names.map do |el_name|
              "keydown:#{el_name}#handleItemWithSubItemKeydown"
            end.join(" ")
          end

          overrides = { "data-item-id": @selected_by_ids.join(" ") }

          super(**system_arguments, **overrides)
        end

        def active?
          item_active?(self) && items.empty?
        end

        # Cause this item to show its list of sub items when rendered.
        def expand!
          @expanded = true
        end

        def before_render
          if active_sub_item?
            expand!

            @content_arguments[:classes] = class_names(
              @content_arguments[:classes],
              "ActionListContent--hasActiveSubItem"
            )
          else
            @system_arguments[:classes] = class_names(
              @system_arguments[:classes],
              "ActionListItem--navActive" => active?
            )
          end

          @content_arguments[:"aria-current"] = "page" if active?

          super

          raise "Cannot render a trailing action for an item with subitems" if items.present? && trailing_action.present?

          raise "Cannot pass `selected_by_ids:` for an item with subitems, since parent items cannot be selected" if items.present? && @selected_by_ids.present?

          return if items.blank?

          @sub_list_arguments[:aria] = merge_aria(
            @sub_list_arguments,
            { aria: { labelledby: id } }
          )

          raise ArgumentError, "Items with sub-items cannot have hrefs" if href.present?

          @content_arguments[:tag] = :button
          @content_arguments[:"aria-expanded"] = @expanded.to_s
          @content_arguments[:"data-action"] = begin
            @list.custom_element_names.flat_map do |el_name|
              [
                "click:#{el_name}#handleItemWithSubItemClick",
                "keydown:#{el_name}#handleItemWithSubItemKeydown"
              ]
            end.join(" ")
          end

          with_private_trailing_action_icon(:"chevron-down", classes: "ActionListItem-collapseIcon")

          @system_arguments[:classes] = class_names(
            @system_arguments[:classes],
            "ActionListItem--hasSubItem"
          )
        end

        def kind
          :item
        end

        private

        # Normally it would be easier to simply ask each item for its active status, eg.
        # items.any?(&:active?), but unfortunately the view context is not set on each
        # item until _after_ the parent's before_render, etc methods have been called.
        # This means helper methods like current_page? will blow up with an error, since
        # `helpers` is simply an alias for the view context (i.e. an instance of
        # ActionView::Base). Since we know the view context for the parent object must
        # be set before `before_render` is invoked, we can call helper methods here in
        # the parent and bypass the problem entirely. Maybe not the most OO approach,
        # but it works.
        def item_active?(item)
          if item.selected_by_ids.present?
            item.selected_by_ids.include?(@selected_item_id)
          elsif item.href
            current_page?(item.href)
          else
            # :nocov:
            false
            # :nocov:
          end
        end

        def active_sub_item?
          items.any? { |subitem| item_active?(subitem) }
        end

        def current_page?(url)
          helpers.current_page?(url)
        end

        def list_class
          Primer::Beta::NavList
        end
      end
    end
  end
end
