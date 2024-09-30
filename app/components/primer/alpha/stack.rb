# frozen_string_literal: true

module Primer
  module Alpha
    # TODO: docs this
    class Stack < Primer::Component
      DEFAULT_JUSTIFY = :start
      JUSTIFY_MAPPING = {
        DEFAULT_JUSTIFY => "start",
        :center => "center",
        :end => "end",
        :space_between => "space-between",
        :space_evenly => "space-evenly"
      }.freeze
      JUSTIFY_OPTIONS = JUSTIFY_MAPPING.keys.freeze

      DEFAULT_DIRECTION = :vertical
      DIRECTION_OPTIONS = [
        DEFAULT_DIRECTION,
        :horizontal
      ].freeze

      DEFAULT_ALIGN = :stretch
      ALIGN_OPTIONS = [
        DEFAULT_ALIGN,
        :start,
        :center,
        :end,
        :baseline
      ].freeze

      DEFAULT_WRAP = :nowrap
      WRAP_OPTIONS = [
        DEFAULT_WRAP,
        :wrap
      ].freeze

      DEFAULT_PADDING = :none
      PADDING_OPTIONS = [
        DEFAULT_PADDING,
        :condensed,
        :normal,
        :spacious
      ].freeze

      DEFAULT_GAP = nil
      GAP_OPTIONS = [
        DEFAULT_GAP,
        :condensed,
        :normal,
        :spacious
      ].freeze

      DEFAULT_TAG = :div

      def initialize(
        tag: DEFAULT_TAG,
        justify: DEFAULT_JUSTIFY,
        gap: nil,
        direction: DEFAULT_DIRECTION,
        align: DEFAULT_ALIGN,
        wrap: DEFAULT_WRAP,
        padding: DEFAULT_PADDING,
        **system_arguments
      )
        @system_arguments = system_arguments

        @system_arguments[:tag] = tag
        @system_arguments[:classes] = class_names(@system_arguments.delete(:classes), "Stack")

        @system_arguments[:data] = merge_data(
          @system_arguments, {
            data: {
              justify: JUSTIFY_MAPPING[
                fetch_or_fallback(JUSTIFY_OPTIONS, justify, DEFAULT_JUSTIFY)
              ],
              gap: fetch_or_fallback(GAP_OPTIONS, gap, DEFAULT_GAP),
              direction: fetch_or_fallback(DIRECTION_OPTIONS, direction, DEFAULT_DIRECTION),
              align: fetch_or_fallback(ALIGN_OPTIONS, align, DEFAULT_ALIGN),
              wrap: fetch_or_fallback(WRAP_OPTIONS, wrap, DEFAULT_WRAP),
              padding: fetch_or_fallback(PADDING_OPTIONS, padding, DEFAULT_PADDING)
            }
          }
        )
      end
    end
  end
end
