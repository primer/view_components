# frozen_string_literal: true

module Primer
  module Beta
    # @label Counter
    class CounterPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param count number
      # @param limit number
      # @param hide_if_zero toggle
      # @param round toggle
      # @param scheme [Symbol] select [[Default, default], [Primary, primary], [Secondary, secondary]]]
      def playground(count: 1_000, limit: nil, round: false, hide_if_zero: false, scheme: :default)
        render(Primer::Beta::Counter.new(count: count, round: round, limit: limit, hide_if_zero: hide_if_zero, scheme: scheme))
      end

      # @label Default Options
      def default
        render(Primer::Beta::Counter.new(count: 1_000))
      end

      # @label With Text
      def with_text
        render(Primer::Beta::Counter.new(text: "∞"))
      end

      # @!group Color Schemes
      #
      # @label Default
      def color_scheme_default
        render(Primer::Beta::Counter.new(count: 1_000))
      end

      # @label Primary
      def color_scheme_primary
        render(Primer::Beta::Counter.new(count: 1_000, scheme: :primary))
      end

      # @label Secondary
      def color_scheme_secondary
        render(Primer::Beta::Counter.new(count: 1_000, scheme: :secondary))
      end
      #
      # @!endgroup

      # @!group Rounded Number
      #
      # @label Default (No Rounding)
      def rounding_default
        render(Primer::Beta::Counter.new(count: 1_234))
      end

      # @label Rounded Above 1,000
      def rounding_above_1000
        render(Primer::Beta::Counter.new(count: 1_234, round: true))
      end

      # @label Rounded Below 1,000
      def rounding_below_1000
        render(Primer::Beta::Counter.new(count: 999, round: true))
      end

      # @label Rounded Large Numbers w/ Default Limit
      def rounding_large_number
        render(Primer::Beta::Counter.new(count: 4_567_890, round: true))
      end

      # @label Rounded Large Numbers, Less Than Custom Limit
      def rounding_large_number_less_than_custom_limit
        render(Primer::Beta::Counter.new(count: 4_567_890, limit: 1_000_000_000, round: true))
      end

      # @label Rounded Large Numbers, Greater Than Custom Limit
      def rounding_large_number_greater_than_custom_limit
        render(Primer::Beta::Counter.new(count: 4_567_890, limit: 1_000_000, round: true))
      end
      #
      # @!endgroup
    end
  end
end
