# frozen_string_literal: true

module Primer
  class SpinnerComponent < Primer::Component

    #
    # @example 48|Default
    #   <%= render(Primer::SpinnerComponent.new()) %>
    #
    # @example 32|Small
    #   <%= render(Primer::SpinnerComponent.new(size: 16)) %>
    #
    # @param size [Integer] Sets the size of the spinner
    def initialize(size: 32, **kwargs)
      @kwargs = kwargs
      @kwargs[:tag] ||= :svg
      @kwargs[:width] = size
      @kwargs[:height] = size
      @kwargs[:viewBox] = "0 0 16 16"
      @kwargs[:fill] = :none
      # Setting `box-sizing: content-box` allows consumers to add padding 
      # to the spinner without shrinking the icon
      @kwargs[:style] = "box-sizing: content-box; color: var(--color-icon-primary);"
    end
  end
end