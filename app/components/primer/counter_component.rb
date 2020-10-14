# frozen_string_literal: true

module Primer
  # Use Primer::CounterComponent to add a count to navigational elements and buttons.
  class CounterComponent < Primer::Component
    DEFAULT_SCHEME = :default
    SCHEME_MAPPINGS = {
      DEFAULT_SCHEME => "Counter",
      :gray => "Counter Counter--gray",
      :light_gray => "Counter Counter--gray-light",
    }.freeze

    #
    # @example 34|Default
    #   <%= render(Primer::CounterComponent.new(count: 25)) %>
    #
    # @param count [Integer, Float::INFINITY, nil] The number to be displayed (e.x. # of issues, pull requests)
    # @param scheme [Symbol] Color scheme. One of `SCHEME_MAPPINGS.keys`.
    # @param limit [Integer] Maximum value to display. (e.x. if count == 6,000 and limit == 5000, counter will display "5,000+")
    # @param hide_if_zero [Boolean] If true, a `hidden` attribute is added to the counter if `count` is zero.
    # @param text [String] Text to display instead of count.
    # @param round [Boolean] Whether to apply our standard rounding logic to value.
    # @param kwargs [Hash] Style arguments to be passed to Primer::Classify
    def initialize(
      count: 0,
      scheme: DEFAULT_SCHEME,
      limit: 5_000,
      hide_if_zero: false,
      text: "",
      round: false,
      **kwargs
    )
      @count, @limit, @hide_if_zero, @text, @round, @kwargs = count, limit, hide_if_zero, text, round, kwargs

      @kwargs[:title] = title
      @kwargs[:tag] = :span
      @kwargs[:classes] = class_names(
        @kwargs[:classes],
        SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_MAPPINGS.keys, scheme, DEFAULT_SCHEME)]
      )
      if count == 0 && hide_if_zero
        @kwargs[:hidden] = true
      end
    end

    def call
      render(Primer::BaseComponent.new(**@kwargs)) { value }
    end

    private

    def title
      if @text.present?
        @text
      elsif @count.nil?
        "Not available"
      elsif @count == Float::INFINITY
        "Infinity"
      else
        count = @count.to_i
        str = number_with_delimiter([count, @limit].min)
        str += "+" if count > @limit
        str
      end
    end

    def value
      if @text.present?
        @text
      elsif @count.nil?
        "" # CSS will hide it
      elsif @count == Float::INFINITY
        "∞"
      else
        if @round
          count = [@count.to_i, @limit].min
          precision = count.between?(100_000, 999_999) ? 0 : 1
          units = {thousand: "k", million: "m", billion: "b"}
          str = number_to_human(count, precision: precision, significant: false, units: units, format: "%n%u")
        else
          @count = @count.to_i
          str = number_with_delimiter([@count, @limit].min)
        end

        str += "+" if @count.to_i > @limit
        str
      end
    end
  end
end
