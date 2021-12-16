# frozen_string_literal: true

module Primer
  module Alpha
    # Use `CtaLink` when you want a link with more visual weight.
    # `CtaLink` has a similar appearance and API to `Button` but always includes a trailing chevron.
    #
    # @accessibility
    #   When the only action is navigating between pages a `CtaLink` should be used instead of a `Button`.
    #   The chevron is a visual indicator to distinguish navigational behaviour from in-page actions.
    #   Link text must be descriptive and meaningful, use an `aria-label` attribute to add additional context if the destination of the link is not clear when reading the link in isolation.
    #
    class CtaLink < Primer::Component
      SCHEME_MAPPINGS = Primer::ButtonComponent::SCHEME_MAPPINGS.except(Primer::ButtonComponent::LINK_SCHEME).freeze
      SCHEME_OPTIONS = SCHEME_MAPPINGS.keys.freeze
      DEFAULT_SCHEME = Primer::ButtonComponent::DEFAULT_SCHEME

      SIZE_OPTIONS = Primer::ButtonComponent::SIZE_OPTIONS.freeze

      # @example Schemes
      #   <%= render(Primer::Alpha::CtaLink.new(href: "#")) { "Default" } %>
      #   <%= render(Primer::Alpha::CtaLink.new(href: "#", scheme: :primary)) { "Primary" } %>
      #   <%= render(Primer::Alpha::CtaLink.new(href: "#", scheme: :danger)) { "Danger" } %>
      #   <%= render(Primer::Alpha::CtaLink.new(href: "#", scheme: :outline)) { "Outline" } %>
      #   <%= render(Primer::Alpha::CtaLink.new(href: "#", scheme: :invisible)) { "Invisible" } %>
      #
      # @example Sizes
      #   <%= render(Primer::Alpha::CtaLink.new(href: "#", size: :small)) { "Small" } %>
      #   <%= render(Primer::Alpha::CtaLink.new(href: "#", size: :medium)) { "Medium" } %>
      #
      # @example As a block
      #   <%= render(Primer::Alpha::CtaLink.new(href: "#", block: true)) { "Block" } %>
      #
      # @param href [String] URL to be used for the Link.
      # @param scheme [Symbol] <%= one_of(Primer::Alpha::CtaLink::SCHEME_OPTIONS) %>
      # @param size [Symbol] <%= one_of(Primer::Alpha::CtaLink::SIZE_OPTIONS) %>
      # @param block [Boolean] Whether button is full-width with `display: block`.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(href:, scheme: DEFAULT_SCHEME, **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)

        @system_arguments[:tag] = :a
        @system_arguments[:dropdown] = false
        @system_arguments[:group_item] = false
        @system_arguments[:href] = href
        @system_arguments[:scheme] = fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)
      end

      def render?
        content.present?
      end
    end
  end
end
