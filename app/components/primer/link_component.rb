# frozen_string_literal: true

module Primer
  # Use links for moving from one page to another. The Link component styles anchor tags with default blue styling and hover text-decoration.
  class LinkComponent < Primer::Component
    status :beta

    # @example Default
    #   <%= render(Primer::LinkComponent.new(href: "http://www.google.com")) { "Link" } %>
    #
    # @example Muted
    #   <%= render(Primer::LinkComponent.new(href: "http://www.google.com", muted: true)) { "Link" } %>
    #
    # @param href [String] URL to be used for the Link
    # @param muted [Boolean] Uses light gray for Link color, and blue on hover
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(href:, muted: false, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = :a
      @system_arguments[:href] = href
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "muted-link" => fetch_or_fallback_boolean(muted, false)
      )
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
