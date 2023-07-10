# frozen_string_literal: true

module Primer
  module Beta
    # @label Link
    class LinkPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param underline [Boolean]
      # @param muted [Boolean]
      # @param scheme [Symbol] select [default, primary, secondary]
      def playground(scheme: :default, muted: false, underline: true)
        render(Primer::Beta::Link.new(href: "#", scheme: scheme, muted: muted, underline: underline)) { "This is a link!" }
      end

      # @label Default Options
      #
      # @param underline [Boolean]
      # @param muted [Boolean]
      # @param scheme [Symbol] select [default, primary, secondary]
      # @snapshot
      def default(scheme: :default, muted: false, underline: true)
        render(Primer::Beta::Link.new(href: "#", scheme: scheme, muted: muted, underline: underline)) { "This is a link!" }
      end

      # @label With Tooltip
      #
      # @param underline [Boolean]
      # @param muted [Boolean]
      # @param scheme [Symbol] select [default, primary, secondary]
      def tooltip(scheme: :default, muted: false, underline: true)
        render(Primer::Beta::Link.new(href: "#", id: "tooltip-link", scheme: scheme, muted: muted, underline: underline)) do |component|
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
      # @snapshot
      def color_scheme_primary
        render(Primer::Beta::Link.new(href: "#", scheme: :primary)) { "This is a primary link color." }
      end

      # @label Primary, Muted
      # @snapshot
      def color_scheme_primary_muted
        render(Primer::Beta::Link.new(href: "#", scheme: :primary, muted: true)) { "This is a muted primary link color." }
      end

      # @label Secondary
      # @snapshot
      def color_scheme_secondary
        render(Primer::Beta::Link.new(href: "#", scheme: :secondary)) { "This is a secondary link color." }
      end

      # @label Secondary, Muted
      # @snapshot
      def color_scheme_secondary_muted
        render(Primer::Beta::Link.new(href: "#", scheme: :secondary, muted: true)) { "This is a muted secondary link color." }
      end
      # @!endgroup
    end
  end
end
