# frozen_string_literal: true

module Primer
  module Beta
    # Use `Spinner` to let users know that content is being loaded.
    class Spinner < Primer::Component
      status :beta

      DEFAULT_SIZE = :medium
      SIZE_MAPPINGS = {
        :small => 16,
        DEFAULT_SIZE => 32,
        :large => 64
      }.freeze

      SIZE_OPTIONS = SIZE_MAPPINGS.keys

      # Setting `box-sizing: content-box` allows consumers to add padding
      # to the spinner without shrinking the icon
      DEFAULT_STYLE = "box-sizing: content-box; color: var(--color-icon-primary);"

      # @param size [Symbol] <%= one_of(Primer::Beta::Spinner::SIZE_MAPPINGS) %>
      # @param style [String] Custom element styles.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(size: DEFAULT_SIZE, style: DEFAULT_STYLE, **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :svg
        @system_arguments[:style] ||= style
        @system_arguments[:animation] = :rotate
        @system_arguments[:width] = SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, DEFAULT_SIZE)]
        @system_arguments[:height] = SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, DEFAULT_SIZE)]
        @system_arguments[:viewBox] = "0 0 16 16"
        @system_arguments[:fill] = :none
      end
    end
  end
end
