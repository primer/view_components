# frozen_string_literal: true

module Primer
  # Use Primer::SpinnerComponent to let users know that content is being loaded.
  class SpinnerComponent < Primer::Component
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
    # @param size [Symbol] <%= one_of(Primer::SpinnerComponent::SIZE_MAPPINGS) %>
    def initialize(size: DEFAULT_SIZE, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = :svg
      @system_arguments[:style] ||= DEFAULT_STYLE
      @system_arguments[:width] = SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, DEFAULT_SIZE)]
      @system_arguments[:height] = SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, DEFAULT_SIZE)]
      @system_arguments[:viewBox] = "0 0 16 16"
      @system_arguments[:fill] = :none
    end
  end
end
