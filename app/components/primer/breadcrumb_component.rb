# frozen_string_literal: true

module Primer
  # Use breadcrumbs to display page hierarchy within a section of the site. All of the items in the breadcrumb "trail" are links except for the final item, which is a plain string indicating the current page.
  class BreadcrumbComponent < Primer::Component
    include ViewComponent::Slotable

    # _Note: if both `href` and `selected: true` are passed in, `href` will be ignored and the item will not be rendered as a link._
    #
    # @param href [String] The URL to link to.
    # @param selected [Boolean] Whether or not the item is selected and not rendered as a link.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_many :items, Primer::Breadcrumb::ItemComponent

    # @example auto|Basic
    #   <%= render(Primer::BreadcrumbComponent.new) do |component| %>
    #     <% component.slot(:item, href: "/") do %>Home<% end %>
    #     <% component.slot(:item, href: "/about") do %>About<% end %>
    #     <% component.slot(:item, selected: true) do %>Team<% end %>
    #   <% end %>
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = :nav
      @system_arguments[:aria] = { label: "Breadcrumb" }
    end

    def render?
      items.any?
    end
  end
end
