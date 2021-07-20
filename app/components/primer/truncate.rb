# frozen_string_literal: true

module Primer
  # Use `Truncate` to shorten overflowing text with an ellipsis.
  class Truncate < Primer::Component
    status :beta

    DEFAULT_TAG = :div
    TAG_OPTIONS = [DEFAULT_TAG, :span, :p, :strong].freeze

    # @example Default
    #   <div class="col-2">
    #     <%= render(Primer::Truncate.new(tag: :p)) { "branch-name-that-is-really-long" } %>
    #   </div>
    #
    # @example Inline
    #   <%= render(Primer::Truncate.new(tag: :span, inline: true)) { "branch-name-that-is-really-long" } %>
    #
    # @example Expandable
    #   <%= render(Primer::Truncate.new(tag: :span, inline: true, expandable: true)) { "branch-name-that-is-really-long" } %>
    #
    # @example Custom size
    #   <%= render(Primer::Truncate.new(tag: :span, inline: true, expandable: true, max_width: 100)) { "branch-name-that-is-really-long" } %>
    #
    # @example With HTML content
    #   <%= render(Primer::Truncate.new(tag: :span, inline: true, expandable: true, max_width: 100)) do %>
    #     <span>branch-name-that-is-really-long</span>
    #   <% end %>
    #
    # @param tag [Symbol] <%= one_of(Primer::Truncate::TAG_OPTIONS) %>
    # @param inline [Boolean] Whether the element is inline (or inline-block).
    # @param expandable [Boolean] Whether the entire string should be revealed on hover. Can only be used in conjunction with `inline`.
    # @param max_width [Integer] Sets the max-width of the text.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(tag: DEFAULT_TAG, inline: false, expandable: false, max_width: nil, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "css-truncate",
        "css-truncate-overflow" => !inline,
        "css-truncate-target" => inline,
        "expandable" => inline && expandable
      )
      @system_arguments[:style] = join_style_arguments(@system_arguments[:style], "max-width: #{max_width}px;") unless max_width.nil?
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
