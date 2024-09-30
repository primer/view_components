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

      BREAKPOINTS = [nil, :narrow, :regular, :wide, :wide]


      def self.get_responsive_attributes(property, values, options = [], default = nil, optionsMap = Hash.new { |h, k| k })

        if !values.is_a?(Array)
          { property => fetch_or_fallback(options, optionsMap[values], default)}
        else
          values.take(BREAKPOINTS.size).each_with_object({}).with_index do |(value, memo), i|
            property_with_breakpoint = [property, BREAKPOINTS[i]].compact.join("-")
            memo[property_with_breakpoint] = fetch_or_fallback(options, optionsMap[value])
          end
        end
      end
    

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
              **get_responsive_attributes('justify', justify, JUSTIFY_OPTIONS, DEFAULT_JUSTIFY, JUSTIFY_MAPPING),
              **get_responsive_attributes('gap', gap, GAP_OPTIONS, DEFAULT_GAP),
              **get_responsive_attributes('direction', direction, DIRECTION_OPTIONS, DEFAULT_DIRECTION),
              **get_responsive_attributes('align', align, ALIGN_OPTIONS, DEFAULT_ALIGN),
              **get_responsive_attributes('wrap', align, WRAP_OPTIONS, DEFAULT_WRAP),
              **get_responsive_attributes('padding', padding, PADDING_OPTIONS, DEFAULT_PADDING),
            }
          }
        )
      end
    end
  end
end
