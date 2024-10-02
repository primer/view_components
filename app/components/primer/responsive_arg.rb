# frozen_string_literal: true

# TODO: should this "live" here?
module Primer
  # Base class for responsive Stack and StackItem arguments. Used internally.
  class ResponsiveArg
    # The primer/react Stack component defines three breakpoints, but PVC uses five.
    # We define this array as an index-based mapping between the two systems. The first
    # element is the default and results in eg. { "justify" => "start" }, while the
    # other breakpoints result in keys with breakpoint suffixes, eg.
    # { "justify-narrow" => "start" }.
    BREAKPOINTS = [nil, :narrow, :regular, :wide, :wide]

    include FetchOrFallbackHelper

    class << self
      def for(values)
        cache[[values, arg_name].hash] ||= new(values)
      end

      private

      def cache
        Thread.current[:pvc_stack_cache] ||= {}
      end
    end

    # :nocov:
    def arg_name
      raise NotImplementedError, "Subclasses must implement the `#{__method__}' method"
    end
    # :nocov:

    def to_data_attributes
      @data_attributes ||= data_attributes_for(self.class.arg_name, values)
    end

    private

    def data_attributes_for(property, values)
      values.take(BREAKPOINTS.size).each_with_object({}).with_index do |(value, memo), i|
        next unless value
        property_with_breakpoint = [property, BREAKPOINTS[i]].compact.join("-")
        memo[property_with_breakpoint] = value
      end
    end

    def fetch_or_fallback_all(allowed_values, given_values, default_value)
      Array(given_values).map do |given_value|
        fetch_or_fallback(allowed_values, given_value, default_value)
      end
    end

    # :nocov:
    def values
      raise NotImplementedError, "Subclasses must implement the `#{__method__}' method"
    end
    # :nocov:
  end
end
