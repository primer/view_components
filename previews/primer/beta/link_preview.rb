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

      # @label Default Options
      #
      # @param underline [Boolean]
      # @param muted [Boolean]
      # @param tag [Symbol] select [a, span]
      # @param scheme [Symbol] select [default, primary, secondary]
      def default(tag: :a, scheme: :default, muted: false, underline: true)
        render(Primer::Beta::Link.new(href: "#", tag: tag, scheme: scheme, muted: muted, underline: underline)) { "This is a link!" }
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

      # @!group Color Scheme
      #
      # @label Default
      def color_scheme_default
        render(Primer::Beta::Link.new(href: "#")) { "This is a default link color." }
      end

      # @label Primary
      def color_scheme_primary
        render(Primer::Beta::Link.new(href: "#", scheme: :primary)) { "This is a primary link color." }
      end

      # @label Primary, Muted
      def color_scheme_primary_muted
        render(Primer::Beta::Link.new(href: "#", scheme: :primary, muted: true)) { "This is a muted primary link color." }
      end

      # @label Secondary
      def color_scheme_secondary
        render(Primer::Beta::Link.new(href: "#", scheme: :secondary)) { "This is a secondary link color." }
      end

      # @label Secondary, Muted
      def color_scheme_secondary_muted
        render(Primer::Beta::Link.new(href: "#", scheme: :secondary, muted: true)) { "This is a muted secondary link color." }
      end
      # @!endgroup
    end
  end
end
