# frozen_string_literal: true

module Primer
  module Alpha
    # `NavList` provides a simple way to render side navigation, i.e. navigation
    # that appears to the left or right side of some main content. Each group in a
    # nav list is a list of links.
    #
    # Nav list groups can contain sub items. Rather than navigating to a URL, groups
    # with sub items expand and collapse on click. To indicate this functionality, the
    # group will automatically render with a trailing chevron icon that changes direction
    # when the group expands and collapses.
    #
    # Nav list items appear visually active when selected. Each nav item must have one
    # or more ID values that determine which item will appear selected. Use the
    # `selected_item_id` argument to select the appropriate item.
    class NavList < Primer::Component
      status :alpha
      audited_at "2023-07-10"

      # @private
      def self.custom_element_name
        "nav-list"
      end

      # The heading for the list at large. Accepts the arguments accepted by <%= link_to_component(Primer::Alpha::NavList::Heading) %>.
      #
      renders_one :heading, Primer::Alpha::NavList::Heading

      # @!parse
      #   # Adds an item to the list.
      #   #
      #   # @param component_klass [Class] The class to use instead of the default <%= link_to_component(Primer::Alpha::NavList::Item) %>
      #   # @param system_arguments [Hash] These arguments are forwarded to <%= link_to_component(Primer::Alpha::NavList::Item) %>, or whatever class is passed as the `component_klass` argument.
      #   def with_item(component_klass: Primer::Alpha::NavList::Item, **system_arguments, &block)
      #   end

      # @!parse
      #   # Adds an avatar item to the list. Avatar items are a convenient way to accessibly add an item with a leading avatar image.
      #   #
      #   # @param src [String] The source url of the avatar image.
      #   # @param username [String] The username associated with the avatar.
      #   # @param full_name [String] Optional. The user's full name.
      #   # @param full_name_scheme [Symbol] Optional. How to display the user's full name. <%= one_of(Primer::Alpha::ActionList::Item::DESCRIPTION_SCHEME_OPTIONS) %>
      #   # @param component_klass [Class] The class to use instead of the default <%= link_to_component(Primer::Alpha::NavList::Item) %>
      #   # @param avatar_arguments [Hash] Optional. The arguments accepted by <%= link_to_component(Primer::Beta::Avatar) %>
      #   # @param system_arguments [Hash] These arguments are forwarded to <%= link_to_component(Primer::Alpha::NavList::Item) %>, or whatever class is passed as the `component_klass` argument.
      #   def with_avatar_item(src:, username:, full_name: nil, full_name_scheme: Primer::Alpha::ActionList::Item::DEFAULT_DESCRIPTION_SCHEME, component_klass: Primer::Alpha::NavList::Item, avatar_arguments: {}, **system_arguments, &block)
      #   end

      # @!parse
      #   # Adds a group to the list. A group is a list of links and a (required) heading.
      #   #
      #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::NavList::Group) %>.
      #   def with_group(**system_arguments, &block)
      #   end

      # @!parse
      #   # Adds a divider to the list. Dividers visually separate items and groups.
      #   #
      #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::NavList::Divider) %>.
      #   def with_divider(**system_arguments, &block)
      #   end

      # Items. Items can be individual items, dividers, or groups. See the documentation for `#with_item`, `#with_divider`, and `#with_group` respectively for more information.
      #
      renders_many :items, types: {
        item: {
          renders: lambda { |**system_arguments, &block|
            build_item(**system_arguments, &block)
          },

          as: :item
        },

        avatar_item: {
          renders: lambda { |**system_arguments|
            build_avatar_item(**system_arguments)
          },

          as: :avatar_item
        },

        divider: {
          renders: Primer::Alpha::NavList::Divider,
          as: :divider
        },

        group: {
          renders: lambda { |**system_arguments, &block|
            Primer::Alpha::NavList::Group.new(
              selected_item_id: @selected_item_id,
              **system_arguments,
              &block
            )
          },

          as: :group
        }
      }

      # @param selected_item_id [Symbol] The ID of the currently selected item. The default is `nil`, meaning no item is selected.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(selected_item_id: nil, **system_arguments)
        @system_arguments = system_arguments
        @selected_item_id = selected_item_id
      end

      # Builds a new item but does not add it to the list. Use this method
      # instead of the `#with_item` slot if you need to render an item outside
      # the context of a list, eg. if rendering additional items to append to
      # an existing list, perhaps via a separate HTTP request.
      #
      # @param component_klass [Class] The class to use instead of the default <%= link_to_component(Primer::Alpha::NavList::Item) %>
      # @param system_arguments [Hash] These arguments are forwarded to <%= link_to_component(Primer::Alpha::NavList::Item) %>, or whatever class is passed as the `component_klass` argument.
      def build_item(component_klass: Primer::Alpha::NavList::Item, **system_arguments, &block)
        component_klass.new(
          list: top_level_group,
          selected_item_id: @selected_item_id,
          **system_arguments,
          &block
        )
      end

      # Builds a new avatar item but does not add it to the list. Avatar items
      # are a convenient way to accessibly add an item with a leading avatar
      # image. Use this method instead of the `#with_avatar_item` slot if you
      # need to render an avatar item outside the context of a list, eg. if
      # rendering additional items to append to an existing list, perhaps via
      # a separate HTTP request.
      #
      # @param src [String] The source url of the avatar image.
      # @param username [String] The username associated with the avatar.
      # @param full_name [String] Optional. The user's full name.
      # @param full_name_scheme [Symbol] Optional. How to display the user's full name. <%= one_of(Primer::Alpha::ActionList::Item::DESCRIPTION_SCHEME_OPTIONS) %>
      # @param component_klass [Class] The class to use instead of the default <%= link_to_component(Primer::Alpha::NavList::Item) %>
      # @param avatar_arguments [Hash] Optional. The arguments accepted by <%= link_to_component(Primer::Beta::Avatar) %>
      # @param system_arguments [Hash] These arguments are forwarded to <%= link_to_component(Primer::Alpha::NavList::Item) %>, or whatever class is passed as the `component_klass` argument.
      def build_avatar_item(src:, username:, full_name: nil, full_name_scheme: Primer::Alpha::ActionList::Item::DEFAULT_DESCRIPTION_SCHEME, component_klass: Primer::Alpha::NavList::Item, avatar_arguments: {}, **system_arguments)
        component_klass.new(
          list: top_level_group,
          selected_item_id: @selected_item_id,
          label: username,
          description_scheme: full_name_scheme,
          **system_arguments
        ).tap do |item|
          item.with_leading_visual_raw_content do
            # no alt text necessary
            item.render(Primer::Beta::Avatar.new(src: src, **avatar_arguments, role: :presentation, size: 16))
          end

          item.with_description_content(full_name) if full_name
        end
      end

      private

      def before_render
        if heading?
          raise ArgumentError, "Please don't set an aria-label if a heading is provided" if aria(:label, @system_arguments)

          @system_arguments[:aria] = merge_aria(
            @system_arguments,
            { aria: { labelledby: heading.id } }
          )
        else
          raise ArgumentError, "When no heading is provided, an aria-label must be given" unless aria(:label, @system_arguments)
        end
      end

      # Lists that contain top-level items (i.e. items outside of a group) should be wrapped in a <ul>
      def render_outer_list?
        items.any? { |item| !group?(item) }
      end

      def render_divider_between?(item1, item2)
        return false if either_is_divider?(item1, item2)

        both_are_groups?(item1, item2) || heterogeneous?(item1, item2)
      end

      def both_are_groups?(item1, item2)
        group?(item1) && group?(item2)
      end

      def heterogeneous?(item1, item2)
        kind(item1) != kind(item2)
      end

      def either_is_divider?(item1, item2)
        divider?(item1) || divider?(item2)
      end

      def group?(item)
        kind(item) == :group
      end

      def divider?(item)
        kind(item) == :divider
      end

      def kind(item)
        item.respond_to?(:kind) ? item.kind : :item
      end

      def top_level_group
        # dummy group for the list: argument in the item slot above
        @top_level_group ||= Primer::Alpha::NavList::Group.new(selected_item_id: @selected_item_id)
      end
    end
  end
end
