# frozen_string_literal: true

module Primer
  # The Truncate component is a wrapper component that will shorten text with an ellipsis.
  class TruncateComponent < Primer::Component
    # @example 25|Default
    #   <%= render(Primer::TruncateComponent.new(tag: :p)) { "branch-name-that-is-really-long" } %>
    #
    # @example 25|Inline
    #   <%= render(Primer::TruncateComponent.new(tag: :span, inline: true)) { "branch-name-that-is-really-long" } %>
    #
    # @example 25|Expandable
    #   <%= render(Primer::TruncateComponent.new(tag: :span, inline: true, expandable: true)) { "branch-name-that-is-really-long" } %>
    #
    # @param inline [Boolean] Whether the element is inline (or inline-block).
    # @param expandable [Boolean] Whether the entire string should be revealed on hover. Can only be used in conjuction with inline.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(inline: false, expandable: false, **system_arguments)
      @align = fetch_or_fallback(ALIGN_OPTIONS, align, ALIGN_DEFAULT)

      @system_arguments = system_arguments
      @system_arguments[:tag] ||= :div
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "css-truncate",
        "css-truncate-overflow" => !inline,
        "css-truncate-target" => inline,
        "expandable" => inline && expandable
      )
    end
  end
end
