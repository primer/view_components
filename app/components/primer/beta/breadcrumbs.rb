# frozen_string_literal: true

module Primer
  module Beta
    # Use `Breadcrumbs` to display page hierarchy.
    # @accessibility
    #   `Breadcrumbs` renders a list of links within a `nav` element and has an implicit landmark role of `navigation`.
    #   By default, the component labels the `nav` element with "Breadcrumbs" which helps distinguish the type of navigation.
    #   Additionally, the component will always render the last link, which should represent the current page, with an `aria-current="page"` attribute.
    #
    #   For more information on the breadcrumbs pattern implemented by this component, see [WAI-ARIA 1.1 Breadcrumb](https://www.w3.org/TR/wai-aria-practices-1.1/#breadcrumb).
    class Breadcrumbs < Primer::Component
      status :beta

      # @param href [String] The URL to link to.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :items, "Item"

      # @example Basic
      #   <%= render(Primer::Beta::Breadcrumbs.new) do |component| %>
      #     <% component.item(href: "/") do %>Home<% end %>
      #     <% component.item(href: "/about") do %>About<% end %>
      #     <% component.item(href: "/about/team") do %>Team<% end %>
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

      # This component is part of `Primer::Beta::Breadcrumbs` and should not be
      # used as a standalone component.
      class Item < Primer::Component
        attr_accessor :selected, :href

        def initialize(href:, **system_arguments)
          @href = href
          @system_arguments = system_arguments
          @selected = false

          @system_arguments[:tag] = :li
          @system_arguments[:classes] = "breadcrumb-item #{@system_arguments[:classes]}"
        end

        def call
          link_arguments = { href: @href }

          if selected
            link_arguments[:"aria-current"] = "page"
            link_arguments[:classes] = "breadcrumb-item-selected"
            @system_arguments[:classes] = "#{@system_arguments[:classes]} breadcrumb-item-selected"
          end

          render(Primer::BaseComponent.new(**@system_arguments)) do
            render(Primer::LinkComponent.new(**link_arguments)) { content }
          end
        end
      end
    end
  end
end
