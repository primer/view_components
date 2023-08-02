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
      #   # @param component_klass [Class] The component class to use. Defaults to `Primer::Alpha::NavList::Item`.
      #   # @param system_arguments [Hash] The arguments accepted by the `component_klass` class.
      #   def with_item(**system_arguments, &block)
      #   end

      # @!parse
      #   # Adds an avatar item to the list. Avatar items are a convenient way to accessibly add an item with a leading avatar image.
      #   #
      #   # @param src [String] The source url of the avatar image.
      #   # @param username [String] The username associated with the avatar.
      #   # @param full_name [String] Optional. The user's full name.
      #   # @param full_name_scheme [Symbol] Optional. How to display the user's full name. <%= one_of(Primer::Alpha::ActionList::Item::DESCRIPTION_SCHEME_OPTIONS) %>
      #   # @param component_klass [Class] The component class to use. Defaults to `Primer::Alpha::NavList::Item`.
      #   # @param avatar_arguments [Hash] Optional. The arguments accepted by <%= link_to_component(Primer::Beta::Avatar) %>.
      #   # @param system_arguments [Hash] The arguments accepted by the `component_klass` class.
      #   def with_avatar_item(src:, username:, full_name: nil, full_name_scheme: Primer::Alpha::ActionList::Item::DEFAULT_DESCRIPTION_SCHEME, avatar_arguments: {}, **system_arguments, &block)
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

      # @example Items and headings
      #
      #   <%= render(Primer::Alpha::NavList.new(aria: { label: "Settings" }, selected_item_id: :personal_info)) do |component| %>
      #     <% component.with_item(label: "General", selected_by_ids: :general, href: "/settings/general") %>
      #     <% component.with_group do |group| %>
      #       <% group.with_heading(title: "Account Settings") %>
      #       <% group.with_item(label: "Personal Information", selected_by_ids: :personal_info, href: "/account/info") %>
      #       <% group.with_item(label: "Password", selected_by_ids: :password, href: "/account/password") %>
      #       <% group.with_item(label: "Billing info", selected_by_ids: :billing, href: "/account/billing") %>
      #     <% end %>
      #   <% end %>
      #
      # @example Leading and trailing visuals
      #
      #   <%= render(Primer::Alpha::NavList.new(aria: { label: "Settings" }, selected_item_id: :personal_info)) do |component| %>
      #     <% component.with_group do |group| %>
      #       <% group.with_heading(title: "Account Settings") %>
      #       <% group.with_avatar_item(src: "https://github.com/github.png", username: "person", selected_by_ids: :personal_info, href: "/account/info") %>
      #       <% group.with_item(label: "Notifications", selected_by_ids: :notifications, href: "/account/notifications") do |item| %>
      #         <% item.with_leading_visual_icon(icon: :bell) %>
      #         <% item.with_trailing_visual_counter(count: 15) %>
      #       <% end %>
      #       <% group.with_item(label: "Billing info", selected_by_ids: :billing, href: "/account/billing") do |item| %>
      #         <% item.with_leading_visual_icon(icon: :package) %>
      #         <% item.with_trailing_visual_icon(icon: :"dot-fill", color: :attention) %>
      #       <% end %>
      #     <% end %>
      #   <% end %>
      #
      # @example Expandable sub items
      #
      #   <%= render(Primer::Alpha::NavList.new(aria: { label: "Settings" }, selected_item_id: :email_notifications)) do |component| %>
      #     <% component.with_group do |group| %>
      #       <% group.with_heading(title: "Account Settings") %>
      #       <% group.with_item(label: "Notification settings") do |item| %>
      #         <% item.with_leading_visual_icon(icon: :bell) %>
      #         <% item.with_item(label: "Email", selected_by_ids: :email_notifications, href: "/account/notifications/email") do |subitem| %>
      #           <% subitem.with_trailing_visual_icon(icon: :mail) %>
      #         <% end %>
      #         <% item.with_item(label: "SMS", selected_by_ids: :sms_notifications, href: "/account/notifications/sms") do |subitem| %>
      #           <% subitem.with_trailing_visual_icon(icon: :"device-mobile") %>
      #         <% end %>
      #       <% end %>
      #       <% group.with_item(label: "Messages") do |item| %>
      #         <% item.with_leading_visual_icon(icon: :bookmark) %>
      #         <% item.with_item(label: "Inbox", href: "/account/messages/inbox") do |subitem| %>
      #           <% subitem.with_trailing_visual_counter(count: 10) %>
      #         <% end %>
      #         <% item.with_item(label: "Organizer", href: "/account/messages/organizer") do |subitem| %>
      #           <% subitem.with_trailing_visual_label(scheme: :primary) { "New" } %>
      #         <% end %>
      #       <% end %>
      #     <% end %>
      #   <% end %>
      #
      # @example Trailing action
      #
      #   <%= render(Primer::Alpha::NavList.new(aria: { label: "Foods" })) do |component| %>
      #     <% component.with_group do |group| %>
      #       <% group.with_heading(title: "My Favorite Foods") %>
      #       <% group.with_item(label: "Popplers", selected_by_ids: :popplers, href: "/foods/popplers") do |item| %>
      #         <% item.with_trailing_action(icon: "plus", "aria-label": "Add new food", size: :medium) %>
      #       <% end %>
      #       <% group.with_item(label: "Slurm", selected_by_ids: :slurm, href: "/foods/slurm") do |item| %>
      #         <% item.with_trailing_action(icon: "plus", "aria-label": "Add new food", size: :medium) %>
      #       <% end %>
      #     <% end %>
      #   <% end %>
      #
      # @param selected_item_id [Symbol] The ID of the currently selected item. The default is `nil`, meaning no item is selected.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(selected_item_id: nil, **system_arguments)
        @system_arguments = system_arguments
        @selected_item_id = selected_item_id
      end

      # @private
      def build_item(component_klass: Primer::Alpha::NavList::Item, **system_arguments, &block)
        component_klass.new(
          list: top_level_group,
          selected_item_id: @selected_item_id,
          **system_arguments,
          &block
        )
      end

      # @private
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
            render(Primer::Beta::Avatar.new(src: src, **avatar_arguments, role: :presentation, size: 16))
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
