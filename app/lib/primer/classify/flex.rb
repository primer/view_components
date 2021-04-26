# frozen_string_literal: true

module Primer
  class Classify
    # Handler for PrimerCSS flex classes.
    class Flex
      FLEX_KEY = :flex
      FLEX_VALUES = [1, :auto].freeze

      WRAP_KEY = :flex_wrap
      WRAP_MAPPINGS = {
        wrap: "flex-wrap",
        nowrap: "flex-nowrap",
        reverse: "flex-wrap-reverse"
      }.freeze

      SHRINK_KEY = :flex_shrink
      SHRINK_VALUES = [0].freeze

      GROW_KEY = :flex_grow
      GROW_VALUES = [0].freeze

      class << self
        def flex(value)
          validate(value, FLEX_VALUES, FLEX_KEY)

          "flex-#{value}"
        end

        def wrap(value)
          validate(value, WRAP_MAPPINGS.keys, WRAP_KEY)

          WRAP_MAPPINGS[value]
        end

        def shrink(value)
          validate(value, SHRINK_VALUES, SHRINK_KEY)

          "flex-shrink-#{value}"
        end

        def grow(value)
          validate(value, GROW_VALUES, GROW_KEY)

          "flex-grow-#{value}"
        end

        private

        def validate(val, allowed_values, key)
          return if Rails.env.production?

          raise ArgumentError, "#{val} is not a valid value for :#{key}. Use one of #{allowed_values}" unless allowed_values.include?(val)
        end
      end
    end
  end
end
