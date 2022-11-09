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
        render(Primer::BaseComponent.new(tag: :div)) do
          "First there's some surrounding text."
          render(Primer::Beta::Link.new(href: "#", id: "tooltip-link", tag: tag, scheme: scheme, muted: muted, underline: underline)) do |component|
            component.with_tooltip(text: "Tooltip text")
            "Link with tooltip"
          end
        end
      end
    end
  end
end
