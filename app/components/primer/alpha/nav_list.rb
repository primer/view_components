# frozen_string_literal: true

module Primer
  module Alpha
    # `NavList` provides a simple way to render side navigation, i.e. navigation
    # that appears to the left or right side of some main content. Each section in a
    # nav list is a list of links.
    #
    # Nav list sections can contain sub items. Rather than navigating to a URL, sections
    # with sub items expand and collapse on click. To indicate this functionality, the
    # section will automatically render with a trailing chevron icon that changes direction
    # when the section expands and collapses.
    #
    # Nav list items appear visually active when selected. Each nav item must have one
    # or more ID values that determine which item will appear selected. Use the
    # `selected_item_id` argument to select the appropriate item.
    class NavList < Primer::Component
      status :alpha

      # Sections. Each section is a list of links and an optional heading.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::NavList::Section) %>.
      renders_many :sections, lambda { |**system_arguments|
        Primer::Alpha::NavList::Section.new(selected_item_id: @selected_item_id, **system_arguments)
      }

      # @example Items and headings
      #
      #   <%= render(Primer::Alpha::NavList.new(selected_item_id: :personal_info)) do |component| %>
      #     <% component.with_section(aria: { label: "Settings" }) do |section| %>
      #       <% section.with_item(label: "General", selected_by_ids: :general, href: "/settings/general") %>
      #     <% end %>
      #     <% component.with_section(aria: { label: "Account settings" }) do |section| %>
      #       <% section.with_heading(title: "Account Settings") %>
      #       <% section.with_item(label: "Personal Information", selected_by_ids: :personal_info, href: "/account/info") %>
      #       <% section.with_item(label: "Password", selected_by_ids: :password, href: "/account/password") %>
      #       <% section.with_item(label: "Billing info", selected_by_ids: :billing, href: "/account/billing") %>
      #     <% end %>
      #   <% end %>
      #
      # @example Leading and trailing visuals
      #
      #   <%= render(Primer::Alpha::NavList.new(selected_item_id: :personal_info)) do |component| %>
      #     <% component.with_section(aria: { label: "Account settings" }) do |section| %>
      #       <% section.with_heading(title: "Account Settings") %>
      #       <% section.with_item(label: "Personal Information", selected_by_ids: :personal_info, href: "/account/info") do |item| %>
      #         <% item.with_leading_visual_avatar(src: "https://github.com/github.png", alt: "GitHub") %>
      #       <% end %>
      #       <% section.with_item(label: "Notifications", selected_by_ids: :notifications, href: "/account/notifications") do |item| %>
      #         <% item.with_leading_visual_icon(icon: :bell) %>
      #         <% item.with_trailing_visual_counter(count: 15) %>
      #       <% end %>
      #       <% section.with_item(label: "Billing info", selected_by_ids: :billing, href: "/account/billing") do |item| %>
      #         <% item.with_leading_visual_icon(icon: :package) %>
      #         <% item.with_trailing_visual_icon(icon: :"dot-fill", color: :attention) %>
      #       <% end %>
      #     <% end %>
      #   <% end %>
      #
      # @example Expandable sub items
      #
      #   <%= render(Primer::Alpha::NavList.new(selected_item_id: :email_notifications)) do |component| %>
      #     <% component.with_section(aria: { label: "Account settings" }) do |section| %>
      #       <% section.with_heading(title: "Account Settings") %>
      #       <% section.with_item(label: "Notification settings", selected_by_ids: :notifications) do |item| %>
      #         <% item.with_leading_visual_icon(icon: :bell) %>
      #         <% item.with_item(label: "Email", selected_by_ids: :email_notifications, href: "/account/notifications/email") do |subitem| %>
      #           <% subitem.with_trailing_visual_icon(icon: :mail) %>
      #         <% end %>
      #         <% item.with_item(label: "SMS", selected_by_ids: :sms_notifications, href: "/account/notifications/sms") do |subitem| %>
      #           <% subitem.with_trailing_visual_icon(icon: :"device-mobile") %>
      #         <% end %>
      #       <% end %>
      #       <% section.with_item(label: "Messages", selected_by_ids: :messages) do |item| %>
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
      #   <%= render(Primer::Alpha::NavList.new) do |component| %>
      #     <% component.with_section(aria: { label: "Favorite foods" }) do |section| %>
      #       <% section.with_heading(title: "My Favorite Foods") %>
      #       <% section.with_item(label: "Popplers", selected_by_ids: :popplers, href: "/foods/popplers") do |item| %>
      #         <% item.with_trailing_action(show_on_hover: false, icon: "plus", "aria-label": "Add new food", size: :medium) %>
      #       <% end %>
      #       <% section.with_item(label: "Slurm", selected_by_ids: :slurm, href: "/foods/slurm") do |item| %>
      #         <% item.with_trailing_action(show_on_hover: true, icon: "plus", "aria-label": "Add new food", size: :medium) %>
      #       <% end %>
      #     <% end %>
      #   <% end %>
      #
      # @param selected_item_id [Symbol] The ID of the currently selected item. The default is `nil`, meaning no item is selected.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(selected_item_id: nil, **system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "ActionListWrap"
        )
        @selected_item_id = selected_item_id
      end
    end
  end
end
