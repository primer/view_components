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


      def initialize(
        justify: DEFAULT_JUSTIFY,
        tag: :div,
        **system_arguments
      )
        @system_arguments = system_arguments
        @system_arguments[:classes] = class_names(@system_arguments.delete(:classes), "Stack")
        @system_arguments[:"data-justify"] = fetch_or_fallback(JUSTIFY_MAPPING, justify, DEFAULT_JUSTIFY)
        @system_arguments[:"tag"] = tag
      end
    end
  end
end
