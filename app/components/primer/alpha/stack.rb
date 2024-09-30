# frozen_string_literal: true

module Primer
  module Alpha
    # TODO: docs this
    class Stack < Primer::Component
      DEFAULT_JUSTIFY = :start
      DEFAULT_DIRECTION = :vertical
      DEFAULT_ALIGN = :stretch
      DEFAULT_WRAP = :nowrap
      DEFAULT_PADDING = :none
      JUSTIFY_MAPPING = {
        DEFAULT_JUSTIFY => "start",
        :center => "center",
        :end => "end",
        :space_between => "space-between",
        :space_evenly => "space-evenly"
      }.freeze


      def initialize(
        justify: DEFAULT_JUSTIFY,
        gap: nil,
        direction: DEFAULT_DIRECTION,
        align: DEFAULT_ALIGN,
        wrap: DEFAULT_WRAP,
        padding: DEFAULT_PADDING,
        tag: :div,
        **system_arguments
      )
        @system_arguments = system_arguments
        @system_arguments[:classes] = class_names(@system_arguments.delete(:classes), "Stack")
        @system_arguments[:"data-justify"] = fetch_or_fallback(JUSTIFY_MAPPING, justify, DEFAULT_JUSTIFY)
        @system_arguments[:"data-gap"] = gap
        @system_arguments[:"data-direction"] = direction
        @system_arguments[:"data-align"] = align
        @system_arguments[:"data-wrap"] = wrap
        @system_arguments[:"data-padding"] = padding
        @system_arguments[:"tag"] = tag
      end
    end
  end
end
