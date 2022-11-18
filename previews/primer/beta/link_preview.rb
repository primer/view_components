# frozen_string_literal: true

module Primer
  module Beta
    # @label Link
    class LinkPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param underline [Boolean]
      # @param muted [Boolean]
      # @param tag [Symbol] select [a, span]
      # @param scheme [Symbol] select [default, primary, secondary]
      def playground(tag: :a, scheme: :default, muted: false, underline: true)
        render(Primer::Beta::Link.new(href: "#", tag: tag, scheme: scheme, muted: muted, underline: underline)) { "This is a link!" }
      end

      # @label Default
      def default
        render(Primer::Beta::Link.new(href: "#")) { "This is a link!" }
      end

      # @label With Tooltip
      #
      # @param underline [Boolean]
      # @param muted [Boolean]
      # @param tag [Symbol] select [a, span]
      # @param scheme [Symbol] select [default, primary, secondary]
      def tooltip(tag: :a, scheme: :default, muted: false, underline: true)
        render(Primer::Beta::Link.new(href: "#", id: "tooltip-link", tag: tag, scheme: scheme, muted: muted, underline: underline)) do |component|
          component.with_tooltip(text: "Tooltip text")
          "Link with tooltip"
        end
      end

      # @!group Options
      #
      # @label Default
      def options_default
        render(Primer::Beta::Link.new(href: "#")) { "Link" }
      end

      # @label Primary
      def options_primary
        render(Primer::Beta::Link.new(href: "#", scheme: :primary)) { "Link" }
      end

      # @label Secondary
      def options_secondary
        render(Primer::Beta::Link.new(href: "#", scheme: :secondary)) { "Link" }
      end

      # @label Muted
      def options_muted
        render(Primer::Beta::Link.new(href: "#", muted: true)) { "Link" }
      end

      # @label Without underline
      def options_underline
        render(Primer::Beta::Link.new(href: "#", underline: false)) { "Link" }
      end
      #
      # @!endgroup
    end
  end
end
