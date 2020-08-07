# frozen_string_literal: true

# Primer::FetchOrFallbackHelper
# A little helper to enable graceful fallbacks
#
# Use this helper to quietly ensure a value is
# one that you expect:
#
# allowed_values  - allowed options for *value*
# given_value     - input being coerced
# fallback        - returned if *given_value* is not included in *allowed_values*
#
# fetch_or_fallback([1,2,3], 5, 2) => 2
# fetch_or_fallback([1,2,3], 1, 2) => 1
# fetch_or_fallback([1,2,3], nil, 2) => 2
module Primer
  module FetchOrFallbackHelper
    include Unloadable

    mattr_accessor :fallback_raises, default: true

    InvalidValueError = Class.new(StandardError)

    def fetch_or_fallback(allowed_values, given_value, fallback = nil)
      if allowed_values.include?(given_value)
        given_value
      else
        if fallback_raises && ENV["RAILS_ENV"] != "production"
          raise InvalidValueError, <<~MSG
            fetch_or_fallback was called with an invalid value.

            Expected one of: #{allowed_values.inspect}
            Got: #{given_value.inspect}

            This will not raise in production, but will instead fallback to: #{fallback.inspect}
          MSG
        end

        fallback
      end
    end
  end
end
