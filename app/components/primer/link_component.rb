# frozen_string_literal: true

module Primer
  # Use `Link` for navigating from one page to another. `Link` styles anchor tags with default blue styling and hover text-decoration.
  class LinkComponent < Primer::Component
    status :beta

    DEFAULT_SCHEME = :default
    SCHEME_MAPPINGS = {
      DEFAULT_SCHEME => "",
      :primary => "Link--primary",
      :secondary => "Link--secondary"
    }.freeze

    DEFAULT_TAG = :a
    TAG_OPTIONS = [DEFAULT_TAG, :span].freeze

    # @example Default
    #   <%= render(Primer::LinkComponent.new(href: "#")) { "Link" } %>
    #
    # @example Muted
    #   <%= render(Primer::LinkComponent.new(href: "#", muted: true)) { "Link" } %>
    #
    # @example Schemes
    #   <%= render(Primer::LinkComponent.new(href: "#", scheme: :primary)) { "Primary" } %>
    #   <%= render(Primer::LinkComponent.new(href: "#", scheme: :secondary)) { "Secondary" } %>
    #
    # @example Without underline
    #   <%= render(Primer::LinkComponent.new(href: "#", underline: false)) { "Link" } %>
    #
    # @example Span as link
    #   <%= render(Primer::LinkComponent.new(tag: :span)) { "Span as a link" } %>
    #
    # @param tag [String]  <%= one_of(Primer::LinkComponent::TAG_OPTIONS) %>
    # @param href [String] URL to be used for the Link. Required if tag is `:a`. If the requirements are not met an error will be raised in non production environments. In production, an empty link element will be rendered.
    # @param scheme [Symbol] <%= one_of(Primer::LinkComponent::SCHEME_MAPPINGS.keys) %>
    # @param muted [Boolean] Uses light gray for Link color, and blue on hover.
    # @param underline [Boolean] Whether or not to underline the link.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(href: nil, tag: DEFAULT_TAG, scheme: DEFAULT_SCHEME, muted: false, underline: true, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)
      @system_arguments[:href] = href
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_MAPPINGS.keys, scheme, DEFAULT_SCHEME)],
        "Link" => tag == :span,
        "Link--muted" => muted,
        "no-underline" => !underline
      )
    end

    def before_render
      raise ArgumentError, "href is required when using <a> tag" if @system_arguments[:tag] == :a && @system_arguments[:href].nil? && !Rails.env.production?
    end
  end
end
