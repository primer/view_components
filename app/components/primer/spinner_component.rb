# frozen_string_literal: true

module Primer
  # Use Primer::SpinnerComponent to let users know that content is being loaded.
  class SpinnerComponent < Primer::Component

    DEFAULT_SIZE = :medium
    SIZE_MAPPINGS = {
      :small => 16,
      DEFAULT_SIZE => 32,
      :large => 64,
    }.freeze
    SIZE_OPTIONS = SIZE_MAPPINGS.keys

    #
    # @example 48|Default
    #   <%= render(Primer::SpinnerComponent.new) %>
    #
    # @example 32|Small
    #   <%= render(Primer::SpinnerComponent.new(size: :small)) %>
    #
    # @example 80|Large
    #   <%= render(Primer::SpinnerComponent.new(size: :large)) %>
    #
    # @param size [Symbol] Sets the size of the spinner
    def initialize(size: DEFAULT_SIZE, **kwargs)
      @kwargs = kwargs
      @kwargs[:tag] ||= :svg
      @kwargs[:width] = SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, DEFAULT_SIZE)]
      @kwargs[:height] = SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, DEFAULT_SIZE)]
      @kwargs[:viewBox] = "0 0 16 16"
      @kwargs[:fill] = :none
      # Setting `box-sizing: content-box` allows consumers to add padding
      # to the spinner without shrinking the icon
      @kwargs[:style] = "box-sizing: content-box; color: var(--color-icon-primary);"
    end
  end
end
