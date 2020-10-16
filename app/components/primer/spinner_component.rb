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
    def initialize(size: 32)
      @size = size
    end
  end
end