# frozen_string_literal: true

module Primer
  module Alpha
    # `NavList` provides a simple way to render side navigation, i.e. navigation
    # that appears to the left or right side of some main content.
    # `NavList` contains a list of navigation items (links) and corresponding leading
    # and trailing visuals such as icons.
    class NavList < ActionList
      status :alpha

      # @example Top-level item and expandable sub list
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
      #       <% list.with_item(label: "Password", selected_by_ids: :password, href: "/account/password") do |item| %>
      #         <% item.with_leading_visual_icon(icon: :key) %>
      #       <% end %>
      #       <% list.with_item(label: "Billing info", selected_by_ids: :billing, href: "/account/billing") do |item| %>
      #         <% item.with_leading_visual_icon(icon: :package) %>
      #         <% item.with_trailing_visual_icon(icon: :"dot-fill", color: :attention) %>
      #       <% end %>
      #     <% end %>
      #   <% end %>
      #
      # @example Additional types of visuals
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
      # @param selected_item_id [Symbol] The ID of the currently selected item. The default is `nil`, meaning no item is selected.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(selected_item_id: nil, **system_arguments)
        @system_arguments = system_arguments
        @selected_item_id = selected_item_id

        aria_label = aria(:label, system_arguments)
        raise ArgumentError, "an aria-label is required" if aria_label.nil?

        super(tag: :nav, **@system_arguments)
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
          selected_item_id: @selected_item_id
        )
      end

      # @private
      def will_add_item(item)
        item.parent.expand! if item.active? && item.parent
      end
    end
  end
end
