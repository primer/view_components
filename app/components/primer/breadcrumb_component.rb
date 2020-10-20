# frozen_string_literal: true

module Primer
  # Breadcrumbs are used to display page hierarchy within a section of the site. All of the items in the breadcrumb "trail" are links except for the final item, which is a plain string indicating the current page.
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
    # @param kwargs [Hash] <%= link_to_style_arguments_docs %>
    def initialize(**kwargs)
      @kwargs = kwargs
      @kwargs[:tag] = :nav
      @kwargs[:aria] = { label: "Breadcrumb" }
    end

    def render?
      items.any?
    end

    # _Note: if both `href` and `selected: true` are passed in, `href` will be ignored and the item will not be rendered as a link._
    class BreadcrumbItem < Primer::Slot
      attr_reader :href, :kwargs

      # @param href [String] The URL to link to.
      # @param selected [Boolean] Whether or not the item is selected and not rendered as a link.
      # @param kwargs [Hash] <%= link_to_style_arguments_docs %>
      def initialize(href: nil, selected: false, **kwargs)
        @href, @kwargs = href, kwargs

        @href = nil if selected
        @kwargs[:tag] = :li
        @kwargs[:"aria-current"] = "page" if selected
        @kwargs[:classes] = "breadcrumb-item #{@kwargs[:classes]}"
      end
    end
  end
end
