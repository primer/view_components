# frozen_string_literal: true

module Primer
  # Use `Spinner` to let users know that content is being loaded.
  class SpinnerComponent < Primer::Component
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

    #
    # @example Default
    #   <%= render(Primer::SpinnerComponent.new) %>
    #
    # @example Small
    #   <%= render(Primer::SpinnerComponent.new(size: :small)) %>
    #
    # @example Large
    #   <%= render(Primer::SpinnerComponent.new(size: :large)) %>
    #
    # @param size [Symbol] <%= one_of(Primer::SpinnerComponent::SIZE_MAPPINGS) %>
    # @param style [String] Custom element styles.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(size: DEFAULT_SIZE, style: DEFAULT_STYLE, **system_arguments)
      @system_arguments = deny_tag_argument(**system_arguments)
      @system_arguments[:tag] = :span
      @system_arguments[:role] = :status
      @system_arguments[:display] = :inline_block
      @system_arguments[:style] ||= style

      @size = SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, DEFAULT_SIZE)]
    end
  end
end
