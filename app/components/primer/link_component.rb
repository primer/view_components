# frozen_string_literal: true

module Primer
  # Use links for moving from one page to another. The Link component styles anchor tags with default blue styling and hover text-decoration.
  class LinkComponent < Primer::Component
    # @example 40|Default
    #   <%= render(Primer::LinkComponent.new(href: "http://www.google.com")) { "Link" } %>
    #
    # @example 40|Muted
    #   <%= render(Primer::LinkComponent.new(href: "http://www.google.com", muted: true)) { "Link" } %>
    #
    # @param href [String] URL to be used for the Link
    # @param muted [Boolean] Uses light gray for Link color, and blue on hover
    # @param kwargs [Hash] <%= link_to_system_arguments_docs %>
    def initialize(href:, muted: false, **kwargs)
      @kwargs = kwargs
      @kwargs[:tag] = :a
      @kwargs[:href] = href
      @kwargs[:classes] = class_names(
        @kwargs[:classes],
        "muted-link" => fetch_or_fallback([true, false], muted, false)
      )
    end

    def call
      render(Primer::BaseComponent.new(**@kwargs)) { content }
    end
  end
end
