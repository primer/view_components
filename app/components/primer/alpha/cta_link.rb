# frozen_string_literal: true

module Primer
  module Alpha
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class CtaLink < Primer::Component
      # @example Schemes
      #   <%= render(Primer::Alpha::CtaLink.new(href: "#")) { "Default" } %>
      #   <%= render(Primer::Alpha::CtaLink.new(href: "#", scheme: :primary)) { "Primary" } %>
      #   <%= render(Primer::Alpha::CtaLink.new(href: "#", scheme: :danger)) { "Danger" } %>
      #   <%= render(Primer::Alpha::CtaLink.new(href: "#", scheme: :outline)) { "Outline" } %>
      #   <%= render(Primer::Alpha::CtaLink.new(href: "#", scheme: :invisible)) { "Invisible" } %>
      #   <%= render(Primer::Alpha::CtaLink.new(href: "#", scheme: :link)) { "Link" } %>
      #
      # @example Sizes
      #   <%= render(Primer::Alpha::CtaLink.new(href: "#", size: :small)) { "Small" } %>
      #   <%= render(Primer::Alpha::CtaLink.new(href: "#", size: :medium)) { "Medium" } %>
      #
      # @param href [String] URL to be used for the Link.
      # @param scheme [Symbol] <%= one_of(Primer::ButtonComponent::SCHEME_OPTIONS) %>
      # @param size [Symbol] <%= one_of(Primer::ButtonComponent::SIZE_OPTIONS) %>
      # @param block [Boolean] Whether button is full-width with `display: block`.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(href:, **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)

        @system_arguments[:tag] = :a
        @system_arguments[:dropdown] = false
        @system_arguments[:group_item] = false
      end
    end
  end
end
