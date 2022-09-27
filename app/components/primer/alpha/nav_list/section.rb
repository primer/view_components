# frozen_string_literal: true

module Primer
  module Alpha
    class NavList
      # A logical grouping of navigation links with an optional heading.
      #
      # See <%= link_to_component(Primer::Alpha::NavList) %> for usage examples.
      class Section < ActionList
        # A special "show more" list item that appears at the bottom of the section. Clicking
        # the item will fetch the next page of results from the URL passed in the `src` argument
        # and append the resulting chunk of HTML to the section.
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
          system_arguments[:id] = "ActionList--showMoreItem"
          system_arguments[:hidden] = true
          system_arguments[:href] = "#"
          system_arguments[:data] ||= {}
          system_arguments[:data][:target] = "nav-list.showMoreItem"
          system_arguments[:data][:action] = "click:nav-list#showMore"
          system_arguments[:data][:"current-page"] = "1"
          system_arguments[:data][:"total-pages"] = pages.to_s
          system_arguments[:label_classes] = class_names(
            system_arguments[:label_classes],
            "color-fg-accent"
          )

          component_klass.new(list: self, src: src, **system_arguments)
        }

        # @private
        def self.custom_element_name
          "nav-list"
        end

        # @param selected_item_id [Symbol] The ID of the currently selected item. Used internally.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(selected_item_id: nil, **system_arguments)
          @system_arguments = system_arguments
          @selected_item_id = selected_item_id
          @system_arguments[:"data-target"] = "nav-list.list"

          super(**@system_arguments)
        end

        # Cause this section to show its list of sub items when rendered.
        def expand!
          @expanded = true
        end

        # The items contained within this section.
        #
        # @return [Array<Primer::Alpha::ActionList::Item>]
        def items
          [*super, show_more_item].tap(&:compact!)
        end

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

        # @private
        def will_add_item(item)
          item.parent.expand! if item.active? && item.parent
        end
      end
    end
  end
end
