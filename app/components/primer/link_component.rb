# frozen_string_literal: true

module Primer
  # Use links for moving from one page to another. The Link component styles anchor tags with default blue styling and hover text-decoration.
  class LinkComponent < Primer::Component
    status :beta

    DEFAULT_VARIANT = :default
    VARIANT_MAPPINGS = {
      DEFAULT_VARIANT => "",
      :primary => "Link--primary",
      :secondary => "Link--secondary"
    }.freeze

    # @example Default
    #   <%= render(Primer::LinkComponent.new(href: "http://www.google.com")) { "Link" } %>
    #
    # @example Muted
    #   <%= render(Primer::LinkComponent.new(href: "http://www.google.com", muted: true)) { "Link" } %>
    #
    # @example Variants
    #   <%= render(Primer::LinkComponent.new(href: "http://www.google.com", variant: :primary)) { "Primary" } %>
    #   <%= render(Primer::LinkComponent.new(href: "http://www.google.com", variant: :secondary)) { "Secondary" } %>
    #
    # @param href [String] URL to be used for the Link.
    # @param variant [Symbol] <%= one_of(Primer::LinkComponent::VARIANT_MAPPINGS.keys) %>
    # @param muted [Boolean] Uses light gray for Link color, and blue on hover.
    # @param underline [Boolean] Whether or not to underline the link.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(href:, variant: DEFAULT_VARIANT, muted: false, underline: true, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = :a
      @system_arguments[:href] = href
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        VARIANT_MAPPINGS[fetch_or_fallback(VARIANT_MAPPINGS.keys, variant, DEFAULT_VARIANT)],
        "Link--muted" => muted,
        "no-underline" => !underline
      )
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
