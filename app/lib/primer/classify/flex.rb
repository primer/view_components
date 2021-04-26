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

      ALIGN_SELF_KEY = :align_self
      ALIGN_SELF_VALUES = [:auto, :start, :end, :center, :baseline, :stretch].freeze

      class << self
        def flex(value)
          generate(
            value: value,
            allowed_values: FLEX_VALUES,
            key: FLEX_KEY,
            prefix: "flex"
          )
        end

        def wrap(value)
          validate(value, WRAP_MAPPINGS.keys, WRAP_KEY)

          WRAP_MAPPINGS[value]
        end

        def shrink(value)
          generate(
            value: value,
            allowed_values: SHRINK_VALUES,
            key: SHRINK_KEY,
            prefix: "flex-shrink"
          )
        end

        def grow(value)
          generate(
            value: value,
            allowed_values: GROW_VALUES,
            key: GROW_KEY,
            prefix: "flex-grow"
          )
        end

        def align_self(value)
          generate(
            value: value,
            allowed_values: ALIGN_SELF_VALUES,
            key: ALIGN_SELF_KEY,
            prefix: "flex-self"
          )
        end

        private

        def generate(value:, allowed_values:, key:, prefix:)
          validate(value, allowed_values, key)

          "#{prefix}-#{value}"
        end

        def validate(val, allowed_values, key)
          return if Rails.env.production?

          raise ArgumentError, "#{val} is not a valid value for :#{key}. Use one of #{allowed_values}" unless allowed_values.include?(val)
        end
      end
    end
  end
end
