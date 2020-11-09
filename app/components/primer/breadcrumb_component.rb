# frozen_string_literal: true

module Primer
  # Use breadcrumbs to display page hierarchy within a section of the site. All of the items in the breadcrumb "trail" are links except for the final item, which is a plain string indicating the current page.
  class BreadcrumbComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :item, collection: true, class_name: "BreadcrumbItem"

    # @example 40|Basic
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

    # _Note: if both `href` and `selected: true` are passed in, `href` will be ignored and the item will not be rendered as a link._
    class BreadcrumbItem < Primer::Slot
      attr_reader :href, :system_arguments

      # @param href [String] The URL to link to.
      # @param selected [Boolean] Whether or not the item is selected and not rendered as a link.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(href: nil, selected: false, **system_arguments)
        @href, @system_arguments = href, system_arguments

        @href = nil if selected
        @system_arguments[:tag] = :li
        @system_arguments[:"aria-current"] = "page" if selected
        @system_arguments[:classes] = "breadcrumb-item #{@system_arguments[:classes]}"
      end
    end
  end
end
