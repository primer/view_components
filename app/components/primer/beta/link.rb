# frozen_string_literal: true

module Primer
  module Beta
    # Use `Link` for navigating from one page to another. `Link` styles anchor tags with default blue styling and hover text-decoration.
    class Link < Primer::Component
      status :beta

      DEFAULT_SCHEME = :default
      SCHEME_MAPPINGS = {
        DEFAULT_SCHEME => "",
        :primary => "Link--primary",
        :secondary => "Link--secondary"
      }.freeze

      # `Tooltip` that appears on mouse hover or keyboard focus over the link. Use tooltips sparingly and as a last resort.
      # **Important:** This tooltip defaults to `type: :description`. In a few scenarios, `type: :label` may be more appropriate.
      # The tooltip will appear adjacent to the anchor element. Both the tooltip and the anchor will be nested
      # under a positioning wrapper.
      # Consult the <%= link_to_component(Primer::Alpha::Tooltip) %> documentation for more information.
      #
      # @param type [Symbol] (:description) <%= one_of(Primer::Alpha::Tooltip::TYPE_OPTIONS) %>
      # @param system_arguments [Hash] Same arguments as <%= link_to_component(Primer::Alpha::Tooltip) %>.
      renders_one :tooltip, lambda { |**system_arguments|
        raise ArgumentError, "Links with a tooltip must have a unique `id` set on the `LinkComponent`." if @id.blank? && !Rails.env.production?

        system_arguments[:for_id] = @id
        system_arguments[:type] ||= :description

        Primer::Alpha::Tooltip.new(**system_arguments)
      }

      # @param href [String] URL to be used for the Link. Required. If the requirements are not met an error will be raised in non production environments. In production, an empty link element will be rendered.
      # @param scheme [Symbol] <%= one_of(Primer::Beta::Link::SCHEME_MAPPINGS.keys) %>
      # @param muted [Boolean] Uses light gray for Link color, and blue on hover.
      # @param underline [Boolean] Whether or not to underline the link.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(href: nil, scheme: DEFAULT_SCHEME, muted: false, underline: true, **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)

        @id = @system_arguments[:id]

        @system_arguments[:tag] = :a
        @system_arguments[:href] = href
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_MAPPINGS.keys, scheme, DEFAULT_SCHEME)],
          "Link",
          "Link--muted" => muted,
          "Link--underline" => underline
        )
      end

      def before_render
        raise ArgumentError, "href is required" if @system_arguments[:href].nil? && !Rails.env.production?
      end

      def call
        if tooltip.present?
          render Primer::BaseComponent.new(tag: :span, position: :relative) do
            render(Primer::BaseComponent.new(**@system_arguments)) do
              content
            end.to_s + tooltip.to_s
          end
        else
          render(Primer::BaseComponent.new(**@system_arguments)) do
            content
          end
        end
      end
    end
  end
end
