# frozen_string_literal: true

module Primer
  module Alpha
    class NavList
      # A logical grouping of navigation links with an optional heading.
      #
      # See <%= link_to_component(Primer::Alpha::NavList) %> for usage examples.
      class Group < ActionList
        # A special "show more" list item that appears at the bottom of the group. Clicking
        # the item will fetch the next page of results from the URL passed in the `src` argument
        # and append the resulting chunk of HTML to the group.
        #
        # @param src [String] The URL to query for additional pages of list items.
        # @param pages [Integer] The total number of pages in the result set.
        # @param component_klass [Class] A component class to use instead of the default `Primer::Alpha::NavList::Item` class.
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::NavList::Item) %>.
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
          system_arguments[:data][:target] = "nav-list.showMoreItem"
          system_arguments[:data][:action] = "click:nav-list#showMore"
          system_arguments[:data][:"current-page"] = "1"
          system_arguments[:data][:"total-pages"] = pages.to_s
          system_arguments[:label_arguments] = {
            **system_arguments[:label_arguments] || {},
            color: :accent
          }

          system_arguments[:content_arguments] = {
            **system_arguments[:content_arguments] || {},
            tag: :button
          }

          component_klass.new(list: self, src: src, **system_arguments)
        }

        def render_in(view_context, &block)
          super do
            yield(self) if block
            show_more_item&.to_s
          end
        end

        # @private
        def self.custom_element_name
          Primer::Alpha::NavList.custom_element_name
        end

        # @param selected_item_id [Symbol] The ID of the currently selected item. Used internally.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(selected_item_id: nil, **system_arguments)
          @system_arguments = system_arguments
          @selected_item_id = selected_item_id
          @system_arguments[:"data-target"] = "nav-list.list"

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
        #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::NavList::Item) %>.
        #   renders_many :items

        # @private
        def build_item(component_klass: NavList::Item, **system_arguments)
          component_klass.new(
            **system_arguments,
            selected_item_id: @selected_item_id,
            list: self
          )
        end
      end
    end
  end
end
