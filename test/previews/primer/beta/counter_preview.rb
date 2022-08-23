# frozen_string_literal: true

module Primer
  module Beta
    # @label Counter
    class CounterPreview < ViewComponent::Preview
      # @label Default Options
      #
      # @param count number
      # @param limit number
      # @param hide_if_zero toggle
      # @param round toggle
      # @param scheme [Symbol] select [[Default, default], [Primary, primary], [Secondary, secondary]]]
      def default(count: 1_000, limit: nil, round: false, hide_if_zero: false, scheme: :default)
        render(Primer::Beta::Counter.new(count: count, round: round, limit: limit, hide_if_zero: hide_if_zero, scheme: scheme))
      end

      # @label With Text
      def with_text
        render(Primer::Beta::Counter.new(text: "∞"))
      end
    end
  end
end
