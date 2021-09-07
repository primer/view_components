# frozen_string_literal: true

module Primer
  module Beta
    # Use `Breadcrumb` to display page hierarchy within a section of the site. All of the items in the breadcrumb "trail" are links except for the final item, which is a plain string indicating the current page.
    class Breadcrumbs < Primer::Component
      status :beta

      # _Note: if both `href` and `selected: true` are passed in, `href` will be ignored and the item will not be rendered as a link._
      #
      # @param href [String] The URL to link to.
      # @param selected [Boolean] Whether or not the item is selected and not rendered as a link.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :items, "Item"

      # @example Basic
      #   <%= render(Primer::Beta::Breadcrumbs.new) do |component| %>
      #     <% component.item(href: "/") do %>Home<% end %>
      #     <% component.item(href: "/about") do %>About<% end %>
      #     <% component.item(selected: true) do %>Team<% end %>
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
        def initialize(href: nil, selected: false, **system_arguments)
          @href = href
          @system_arguments = system_arguments

          @href = nil if selected
          @system_arguments[:tag] = :li
          @system_arguments[:"aria-current"] = "page" if selected
          @system_arguments[:classes] = "breadcrumb-item #{@system_arguments[:classes]}"
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) do
            if @href.present?
              render(Primer::LinkComponent.new(href: @href)) { content }
            else
              content
            end
          end
        end
      end
    end
  end
end
