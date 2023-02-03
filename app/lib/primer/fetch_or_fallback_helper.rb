# frozen_string_literal: true

# Primer::FetchOrFallbackHelper
# A little helper to enable graceful fallbacks
#
# Use this helper to quietly ensure a value is
# one that you expect:
#
# allowed_values    - allowed options for *value*
# given_value       - input being coerced
# fallback          - returned if *given_value* is not included in *allowed_values*
# deprecated_values - deprecated options for *value*. Will warn of deprecation if not in production
#
# fetch_or_fallback([1,2,3], 5, 2) => 2
# fetch_or_fallback([1,2,3], 1, 2) => 1
# fetch_or_fallback([1,2,3], nil, 2) => 2
#
# With deprecations:
# fetch_or_fallback([1,2], 3, 2, deprecated_values: [3]) => 3
# fetch_or_fallback([1,2], nil, 2, deprecated_values: [3]) => 2
module Primer
  # :nodoc:
  module FetchOrFallbackHelper
    mattr_accessor :fallback_raises, default: true

    InvalidValueError = Class.new(StandardError)

    def fetch_or_fallback(allowed_values, given_value, fallback = nil, deprecated_values: nil)
      if allowed_values.include?(given_value)
        given_value
      elsif deprecated_values&.include?(given_value)
        ActiveSupport::Deprecation.warn("#{given_value} is deprecated and will be removed in a future version.") unless Rails.env.production? || silence_deprecations?

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

    # rubocop:disable Style/OptionalBooleanParameter
    def fetch_or_fallback_boolean(given_value, fallback = false)
      if [true, false].include?(given_value)
        given_value
      else
        fallback
      end
    end
    # rubocop:enable Style/OptionalBooleanParameter

    def silence_deprecations?
      Rails.application.config.primer_view_components.silence_deprecations
    end
  end
end
