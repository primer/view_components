# frozen_string_literal: true

module Primer
  # Base class for responsive Stack and StackItem arguments. Used internally.
  class ResponsiveArg
    BREAKPOINTS = [:narrow, :regular, :wide].freeze

    include FetchOrFallbackHelper

    class << self
      def for(values)
        cache[[values, arg_name].hash] ||= new(values)
      end

      # :nocov:
      def arg_name
        raise NotImplementedError, "Subclasses must implement the `#{__method__}' method"
      end
      # :nocov:

      private

      def cache
        Thread.current[:pvc_stack_cache] ||= {}
      end
    end

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
        values ? { property => values } : {}
      end
    end

    def fetch_or_fallback_all(options, values, default)
      if values.is_a?(Hash)
        values.each_with_object({}) do |(key, value), memo|
          memo[key] = fetch_or_fallback(options, value, default).yield_self do |value|
            block_given? ? yield(value) : value
          end
        end
      else
        fetch_or_fallback(options, values, default).yield_self do |value|
          block_given? ? yield(value) : value
        end
      end
    end

    # :nocov:
    def values
      raise NotImplementedError, "Subclasses must implement the `#{__method__}' method"
    end
    # :nocov:
  end
end
