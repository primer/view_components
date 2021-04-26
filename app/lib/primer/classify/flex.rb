# frozen_string_literal: true

module Primer
  class Classify
    # Handler for PrimerCSS flex classes.
    class Flex
      WRAP_KEY = :flex_wrap
      WRAP_MAPPINGS = {
        wrap: "flex-wrap",
        nowrap: "flex-nowrap",
        reverse: "flex-wrap-reverse"
      }.freeze

      SHRINK_KEY = :flex_shrink
      SHRINK_VALUES = [0].freeze

      class << self
        def shrink(value)
          validate(value, SHRINK_VALUES, SHRINK_KEY) unless Rails.env.production?

          "flex-shrink-0"
        end


        def wrap(value)
          validate(value, WRAP_MAPPINGS.keys, WRAP_KEY) unless Rails.env.production?

          WRAP_MAPPINGS[value]
        end

        private

        def validate(val, allowed_values, key)
          raise ArgumentError, "#{val} is not a valid value for :#{key}. Use one of #{allowed_values}" unless allowed_values.include?(val)
        end
      end
    end
  end
end
