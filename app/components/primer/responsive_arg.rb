# frozen_string_literal: true

module Primer
  # Base class for responsive Stack and StackItem arguments. Used internally.
  class ResponsiveArg
    # TODO: rewrite
    # The primer/react Stack component defines three breakpoints, but PVC uses five.
    # We define this array as an index-based mapping between the two systems. The first
    # element is the default and results in eg. { "justify" => "start" }, while the
    # other breakpoints result in keys with breakpoint suffixes, eg.
    # { "justify-narrow" => "start" }. 
    BREAKPOINTS = [:narrow, :regular, :wide].freeze

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
      if values.is_a?(Hash)
        values.slice(*BREAKPOINTS).each_with_object({}) do |(key, value), memo|
          next unless value
          property_with_breakpoint = "#{property}-#{key}"
          memo[property_with_breakpoint] = value
        end
      else
        {property => values}
      end
    end

    def fetch_or_fallback_all(options, values, default)
      if values.is_a?(Hash)
        values.each_with_object({}) do |(key, value), memo|
          value = block_given? ? yield(value) : value
          memo[key] = fetch_or_fallback(options, value, default)
        end
      else
        value = block_given? ? yield(values) : values
        fetch_or_fallback(options, value, default)
      end
    end

    # :nocov:
    def values
      raise NotImplementedError, "Subclasses must implement the `#{__method__}' method"
    end
    # :nocov:
  end
end
