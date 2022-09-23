# frozen_string_literal: true

module Primer
  module Alpha
    # `NavList` provides a simple way to render side navigation, i.e. navigation
    # that appears to the left or right side of some main content. Each item in a
    # nav list is a link along with corresponding leading and trailing visuals.
    #
    # Nav list items can either be single items or sub lists. Rather than navigating
    # to a URL, sub lists expand and collapse on click. To indicate this functionality,
    # sub lists automatically render with a trailing chevron that changes direction
    # when the sub list expands and collapses.
    #
    # Nav list items appear visually active when selected. Each nav item must have one
    # or more ID values that determine which item will appear selected. Use the
    # `selected_item_id` argument to select the appropriate nav item.
    class NavList < ActionList
      status :alpha

      # A special "show more" list item that appears at the bottom of the list. When
      # clicked, this list item will fetch the next page of results from the URL passed
      # in the `src` argument and append the resulting chunk of HTML to the list.
      #
      # @param pages [Integer] The total number of pages in the result set.
      # @param component_klass [Class] A component class to use instead of the default `Primer::Alpha::NavList::Item` class.
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Item) %>.
      renders_one :show_more_item, lambda { |pages:, component_klass: Item, **system_arguments|
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

        component_klass.new(list: self, **system_arguments)
      }

      # @example Top-level items with header
      #
      #   <%= render(Primer::Alpha::NavList.new(aria: { label: "Settings" }, selected_item_id: :personal_info)) do |component| %>
      #     <% component.with_item(label: "General", selected_by_ids: :general, href: "/settings/general") %>
      #     <% component.with_list(aria: { label: "Account settings" }) do |list| %>
      #       <% list.with_heading(title: "Account Settings") %>
      #       <% list.with_item(label: "Personal Information", selected_by_ids: :personal_info, href: "/account/info") %>
      #       <% list.with_item(label: "Password", selected_by_ids: :password, href: "/account/password") %>
      #       <% list.with_item(label: "Billing info", selected_by_ids: :billing, href: "/account/billing") %>
      #     <% end %>
      #   <% end %>
      #
      # @example Leading and trailing visuals
      #
      #   <%= render(Primer::Alpha::NavList.new(aria: { label: "Settings" }, selected_item_id: :personal_info)) do |component| %>
      #     <% component.with_list(aria: { label: "Account settings" }) do |list| %>
      #       <% list.with_heading(title: "Account Settings") %>
      #       <% list.with_item(label: "Personal Information", selected_by_ids: :personal_info, href: "/account/info") do |item| %>
      #         <% item.with_leading_visual_avatar(src: "https://github.com/github.png", alt: "GitHub") %>
      #       <% end %>
      #       <% list.with_item(label: "Notifications", selected_by_ids: :notifications, href: "/account/notifications") do |item| %>
      #         <% item.with_leading_visual_icon(icon: :bell) %>
      #         <% item.with_trailing_visual_counter(count: 15) %>
      #       <% end %>
      #       <% list.with_item(label: "Billing info", selected_by_ids: :billing, href: "/account/billing") do |item| %>
      #         <% item.with_leading_visual_icon(icon: :package) %>
      #         <% item.with_trailing_visual_icon(icon: :"dot-fill", color: :attention) %>
      #       <% end %>
      #     <% end %>
      #   <% end %>
      #
      # @example Expandable sub lists
      #
      #   <%= render(Primer::Alpha::NavList.new(aria: { label: "Settings" }, selected_item_id: :email_notifications)) do |component| %>
      #     <% component.with_list(aria: { label: "Account settings" }) do |list| %>
      #       <% list.with_heading(title: "Account Settings") %>
      #       <% list.with_item(label: "Notification settings", selected_by_ids: :notifications) do |item| %>
      #         <% item.with_leading_visual_icon(icon: :bell) %>
      #         <% item.with_item(label: "Email", selected_by_ids: :email_notifications, href: "/account/notifications/email") do |subitem| %>
      #           <% subitem.with_trailing_visual_icon(icon: :mail) %>
      #         <% end %>
      #         <% item.with_item(label: "SMS", selected_by_ids: :sms_notifications, href: "/account/notifications/sms") do |subitem| %>
      #           <% subitem.with_trailing_visual_icon(icon: :"device-mobile") %>
      #         <% end %>
      #       <% end %>
      #       <% list.with_item(label: "Messages", selected_by_ids: :messages) do |item| %>
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
      #   <%= render(Primer::Alpha::NavList.new(aria: { label: "Foods list" })) do |component| %>
      #     <% component.with_list(aria: { label: "Favorite foods" }) do |list| %>
      #       <% list.with_heading(title: "My Favorite Foods") %>
      #       <% list.with_item(label: "Popplers", selected_by_ids: :popplers, href: "/foods/popplers") do |item| %>
      #         <% item.with_trailing_action(show_on_hover: false, icon: "plus", "aria-label": "Add new food", size: :medium) %>
      #       <% end %>
      #       <% list.with_item(label: "Slurm", selected_by_ids: :slurm, href: "/foods/slurm") do |item| %>
      #         <% item.with_trailing_action(show_on_hover: true, icon: "plus", "aria-label": "Add new food", size: :medium) %>
      #       <% end %>
      #     <% end %>
      #   <% end %>
      #
      # @param selected_item_id [Symbol] The ID of the currently selected item. The default is `nil`, meaning no item is selected.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(selected_item_id: nil, **system_arguments)
        @system_arguments = system_arguments
        @selected_item_id = selected_item_id

        @system_arguments[:"data-target"] = "nav-list.list"

        aria_label = aria(:label, system_arguments)
        raise ArgumentError, "an aria-label is required" if aria_label.nil?

        super(tag: :nav, **@system_arguments)
      end

      # @!parse
      #   # Top-level items that render above all sub lists.
      #   #
      #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::NavList::Item) %>.
      #   renders_many :items

      # @!parse
      #   # Sub lists, i.e. items that contain sub items.
      #   #
      #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::NavList) %>.
      #   renders_many :lists

      # The items contained within this nav list.
      #
      # @return [Array<Primer::Alpha::ActionList::Item>]
      def items
        [*super, show_more_item].tap(&:compact!)
      end

      # @private
      def build_item(component_klass: NavList::Item, **system_arguments)
        component_klass.new(
          **system_arguments,
          selected_item_id: @selected_item_id,
          list: self
        )
      end

      # @private
      def build_list(**system_arguments)
        NavList.new(
          **system_arguments,
          selected_item_id: @selected_item_id,
          "data-target": "nav-list.list"
        )
      end

      # @private
      def will_add_item(item)
        item.parent.expand! if item.active? && item.parent
      end
    end
  end
end
