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

    # `Tooltip` that appears on mouse hover or keyboard focus over the link. Use tooltips sparingly and as a last resort.
    # **Important:** This tooltip defaults to `type: :description`. In a few scenarios, `type: :label` may be more appropriate.
    # Consult the <%= link_to_component(Primer::Alpha::Tooltip) %> documentation for more information.
    #
    # @param type [Symbol] (:description) <%= one_of(Primer::Alpha::Tooltip::TYPE_OPTIONS) %>
    # @param system_arguments [Hash] Same arguments as <%= link_to_component(Primer::Alpha::Tooltip) %>.
    renders_one :tooltip, lambda { |**system_arguments|
      raise ArgumentError, "Links with a tooltip must have a unique `id` set on the `LinkComponent`." if @id.blank? && !Rails.env.production?

      @system_arguments = system_arguments

      @system_arguments[:for_id] = @id
      @system_arguments[:type] ||= :description

      Primer::Alpha::Tooltip.new(**@system_arguments)
    }

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
    # @example With tooltip
    #   @description
    #     Use tooltips sparingly and as a last resort. Consult the <%= link_to_component(Primer::Alpha::Tooltip) %> documentation for more information.
    #   @code
    #     <%= render(Primer::LinkComponent.new(href: "#", id: "link-with-tooltip")) do |c| %>
    #       <% c.tooltip(text: "Tooltip text") %>
    #       Link
    #     <% end %>
    #
    # @param tag [String]  <%= one_of(Primer::LinkComponent::TAG_OPTIONS) %>
    # @param href [String] URL to be used for the Link. Required if tag is `:a`. If the requirements are not met an error will be raised in non production environments. In production, an empty link element will be rendered.
    # @param scheme [Symbol] <%= one_of(Primer::LinkComponent::SCHEME_MAPPINGS.keys) %>
    # @param muted [Boolean] Uses light gray for Link color, and blue on hover.
    # @param underline [Boolean] Whether or not to underline the link.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(href: nil, tag: DEFAULT_TAG, scheme: DEFAULT_SCHEME, muted: false, underline: true, **system_arguments)
      @system_arguments = system_arguments

      @id = @system_arguments[:id]

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
