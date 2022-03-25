# frozen_string_literal: true

module Primer
  module Alpha
    # `NavigationList` provides a simple way to render side navigation, i.e. navigation
    # that appears to the left or right side of some main content.
    # `NavigationList` contains a list of navigation items (links) and corresponding leading
    # and trailing visuals such as icons. Items can themselves have sub-items.
    # Finally, `NavigationList` supports sections, which are logical groups of items with
    # a section header.
    class NavigationList < Primer::Component
      # Top-level nav items shown above all sections.
      #
      # @param component_klass [Class] A custom component class to use instead of the default Item class.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :items, lambda { |component_klass: Item, **system_arguments|
        system_arguments[:classes] = class_names(
          @item_classes,
          system_arguments[:classes]
        )

        component_klass.new(selected_item_id: @selected_item_id, **system_arguments)
      }

      # Sections.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :sections, lambda { |**system_arguments|
        Section.new(selected_item_id: @selected_item_id, item_classes: @item_classes, **system_arguments)
      }

      # @example Default
      #
      #   <%= render(Primer::Alpha::NavigationList.new(aria: { label: "Settings" }, selected_item_id: :personal_info)) do |component| %>
      #     <% component.item(item_id: :general, href: "/settings/general")
      #     <% component.section(aria: { label: "Account settings" }) do |section|
      #       <% section.heading do %>
      #         Account Settings
      #       <% end %>
      #       <% section.item(item_id: :personal_info, href: "/account/info") do %>
      #         Personal Information
      #       <% end %>
      #       <% section.item(item_id: :password, href: "/account/password") do %>
      #         Password
      #       <% end %>
      #       <% section.item(item_id: :billing, href: "/account/billing") do %>
      #         Billing info
      #       <% end %>
      #     <% end %>
      #   <% end %>
      #
      # @example Items with leading and trailing visuals
      #
      #   <%= render(Primer::Alpha::NavigationList.new(aria: { label: "Settings" }, selected_item_id: :personal_info)) do |component| %>
      #     <% component.section(aria: { label: "Account settings" }) do |section|
      #       <% section.heading do %>
      #         Account Settings
      #       <% end %>
      #       <% section.item(item_id: :personal_info, href: "/account/info") do |item| %>
      #         Personal Information
      #         <% item.leading_visual_avatar(src: "https://github.com/github.png", alt: "GitHub") %>
      #       <% end %>
      #       <% section.item(item_id: :password, href: "/account/password") do |item| %>
      #         Password
      #         <% item.leading_visual_icon(icon: :key) %>
      #       <% end %>
      #       <% section.item(item_id: :billing, href: "/account/billing") do |item| %>
      #         Billing info
      #         <% item.leading_visual_icon(icon: :package) %>
      #         <% unless current_user.account.in_good_standing? %>
      #           <% item.trailing_visual_icon(icon: :"dot-fill", color: :attention) %>
      #         <% end %>
      #       <% end %>
      #     <% end %>
      #   <% end %>
      #
      # @example Items with sub-items
      #
      #   <%= render(Primer::Alpha::NavigationList.new(aria: { label: "Settings" }, selected_item_id: :email_notifications)) do |component| %>
      #     <% component.section(aria: { label: "Account settings" }) do |section|
      #       <% section.heading do %>
      #         Account Settings
      #       <% end %>
      #       <% section.item(item_id: :notifications, label: "Notifications settings") do |item| %>
      #         Notifications
      #         <% item.leading_visual_icon(icon: :bell) %>
      #         <% item.subitem(item_id: :email_notifications, href: "/account/notifications/email") do |subitem| %>
      #           Email
      #           <% subitem.trailing_visual_icon(icon: :mail) %>
      #         <% end %>
      #         <% item.subitem(item_id: :sms_notifications, href: "/account/notifications/sms") do |subitem| %>
      #           SMS
      #           <% subitem.trailing_visual_icon(icon: :"device-mobile") %>
      #         <% end %>
      #       <% end %>
      #       <% section.item(item_id: :messages, label: "Notifications settings") do |item| %>
      #         Messages
      #         <% item.leading_visual_icon(icon: :bookmark) %>
      #         <% item.subitem(href: "/account/messages/inbox") do |subitem| %>
      #           Inbox
      #           <% subitem.trailing_visual_counter(count: 10) %>
      #         <% end %>
      #         <% item.subitem(href: "/account/messages/organizer") do |subitem| %>
      #           Organizer
      #           <% subitem.trailing_visual_label(scheme: :primary) { "New" } %>
      #         <% end %>
      #       <% end %>
      #     <% end %>
      #   <% end %>
      #
      # @param selected_item_id [Symbol] The id of the selected item. Should correspond to one of the item ids in the list.
      # @param item_classes [Array<String>] Additional classes to add to the list's items.
      # @param list_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(selected_item_id: nil, item_classes: "", **list_arguments)
        @list_arguments = list_arguments
        @list_arguments[:classes] = class_names(
          "ActionList",
          @list_arguments[:classes]
        )

        aria_label = aria(:label, list_arguments)
        raise ArgumentError, "an aria-label is required" if aria_label.nil?

        @nav_arguments = { aria: { label: aria_label } }

        @selected_item_id = selected_item_id
        @item_classes = item_classes
      end
    end
  end
end
