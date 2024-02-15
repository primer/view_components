# frozen_string_literal: true

module Primer
  module Beta
    class NavList
      # A logical grouping of navigation links with an optional heading.
      #
      # See <%= link_to_component(Primer::Beta::NavList) %> for usage examples.
      class Group < Primer::Alpha::ActionList
        # A special "show more" list item that appears at the bottom of the group. Clicking
        # the item will fetch the next page of results from the URL passed in the `src` argument
        # and append the resulting chunk of HTML to the group.
        #
        # @param src [String] The URL to query for additional pages of list items.
        # @param pages [Integer] The total number of pages in the result set.
        # @param component_klass [Class] A component class to use instead of the default `Primer::Beta::NavList::Item` class.
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Beta::NavList::Item) %>.
        renders_one :show_more_item, lambda { |src:, pages:, component_klass: NavList::Item, **system_arguments|
          system_arguments[:classes] = class_names(
            @item_classes,
            system_arguments[:classes]
          )
          system_arguments[:tag] = :div
          system_arguments[:id] ||= self.class.generate_id(base_name: "item")
          system_arguments[:hidden] = true
          system_arguments[:href] = "#"
          system_arguments[:data] ||= {}
          system_arguments[:data][:target] = "nav-list-group.showMoreItem"
          system_arguments[:data][:action] = "click:nav-list-group#showMore"
          system_arguments[:data][:current_page] = "1"
          system_arguments[:data][:total_pages] = pages.to_s
          system_arguments[:label_arguments] = {
            **system_arguments[:label_arguments] || {},
            color: :accent
          }

          system_arguments[:content_arguments] = {
            **system_arguments[:content_arguments] || {},
            tag: :button
          }

          system_arguments[:content_arguments][:data] = merge_data(
            system_arguments[:content_arguments],
            data: { list_id: id }
          )

          component_klass.new(list: self, src: src, **system_arguments)
        }

        # @private
        def self.custom_element_names
          Primer::Beta::NavList.custom_element_names
        end

        # @param selected_item_id [Symbol] The ID of the currently selected item. Used internally.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(selected_item_id: nil, **system_arguments)
          @system_arguments = system_arguments
          @selected_item_id = selected_item_id

          super(**@system_arguments)
        end

        # Cause this group to show its list of sub items when rendered.
        # :nocov:
        def expand!
          @expanded = true
        end
        # :nocov:

        # @!parse
        #   # Items.
        #   #
        #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Beta::NavList::Item) %>.
        #   renders_many :items

        # @private
        def build_item(component_klass: NavList::Item, **system_arguments)
          super(
            component_klass: component_klass,
            selected_item_id: @selected_item_id,
            **system_arguments
          )
        end

        # @private
        def build_avatar_item(component_klass: NavList::Item, **system_arguments)
          super(
            component_klass: component_klass,
            selected_item_id: @selected_item_id,
            **system_arguments
          )
        end

        def kind
          :group
        end

        def before_render
          super

          raise ArgumentError, "NavList groups are required to have headings" unless heading?
        end
      end
    end
  end
end
