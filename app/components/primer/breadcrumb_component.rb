# frozen_string_literal: true

##
# Breadcrumbs are used to display page hierarchy within a section of the site. All of the items in the breadcrumb "trail" are links except for the final item which is a plain string indicating the current page.
#
# ## Example
#
# The `Primer::BreadcrumbComponent` uses the [Slots API](https://github.com/github/view_component#slots-experimental) and at least one slot is required for the component to render. Each slot can accept the following parameters:
#
# 1. `href` (string). The URL to link to.
# 2. `selected` (boolean, default=false). Flag indicating whether or not the item is selected and not rendered as a link.
#
# Note that if if both `href` and `selected: true` are passed in, `href` will be ignored and the item will not be rendered as a link.
#
# ```ruby
# <%= render(Primer::BreadcrumbComponent.new) do |component| %>
#   <% component.slot(:item, href: "/") do %>Home<% end %>
#   <% component.slot(:item, href: "/about") do %>About<% end %>
#   <% component.slot(:item, selected: true) do %>Team<% end %>
# <% end %>
# ```
##
module Primer
  class BreadcrumbComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :item, collection: true, class_name: "BreadcrumbItem"

    def initialize(**kwargs)
      @kwargs = kwargs
      @kwargs[:tag] = :nav
      @kwargs[:aria] = { label: "Breadcrumb" }
    end

    def render?
      items.any?
    end

    class BreadcrumbItem < Primer::Slot
      attr_reader :href, :kwargs

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
