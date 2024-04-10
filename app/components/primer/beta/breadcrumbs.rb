# frozen_string_literal: true

module Primer
  module Beta
    # Use `Breadcrumbs` to display page hierarchy.
    #
    # #### Known issues
    #
    # ##### Responsiveness
    #
    # `Breadcrumbs` is not optimized for responsive designs.
    #
    # @accessibility
    #   `Breadcrumbs` renders a list of links within a `nav` element and has an implicit landmark role of `navigation`.
    #   By default, the component labels the `nav` element with "Breadcrumbs" which helps distinguish the type of navigation.
    #   Additionally, the component will always render the last link, which should represent the current page, with an `aria-current="page"` attribute.
    #
    #   For more information on the breadcrumbs pattern implemented by this component, see [WAI-ARIA 1.1 Breadcrumb](https://www.w3.org/TR/wai-aria-practices-1.1/#breadcrumb).
    class Breadcrumbs < Primer::Component
      status :beta

      PADDING_MESSAGE = "Padding system arguments are not allowed on Breadcrumbs. Consider using margins instead."
      FONT_SIZE_MESSAGE = "Breadcrumbs do not support the font_size system argument."
      ARIA_LABEL = { label: "Breadcrumb" }.freeze
      ARGS_DENYLIST = {
        [:p, :pt, :pb, :pr, :pl, :px, :py] => PADDING_MESSAGE,
        [:font_size] => FONT_SIZE_MESSAGE
      }.freeze

      # @param href [String] The URL to link to.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :items, "Item"

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :nav
        @system_arguments[:aria] = ARIA_LABEL
        @system_arguments[:system_arguments_denylist] = ARGS_DENYLIST
      end

      def render?
        items.any?
      end

      # This component is part of `Primer::Beta::Breadcrumbs` and should not be
      # used as a standalone component.
      class Item < Primer::Component
        attr_accessor :selected, :href

        def initialize(href:, target: "_self", **system_arguments)
          @href = href
          @target = target
          @system_arguments = deny_tag_argument(**system_arguments)
          @selected = false

          @system_arguments[:tag] = :li
          @system_arguments[:classes] = "breadcrumb-item #{@system_arguments[:classes]}"
        end

        def call
          link_arguments = { href: @href, target: @target }

          if selected
            link_arguments[:"aria-current"] = "page"
            @system_arguments[:classes] = "#{@system_arguments[:classes]} breadcrumb-item-selected"
          end

          render(Primer::BaseComponent.new(**@system_arguments)) do
            render(Primer::Beta::Link.new(**link_arguments)) { content }
          end
        end
      end
    end
  end
end
