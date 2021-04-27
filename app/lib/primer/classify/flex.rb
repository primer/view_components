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

      DIRECTION_KEY = :direction
      DIRECTION_VALUES = [:column, :column_reverse, :row, :row_reverse].freeze

      JUSTIFY_CONTENT_KEY = :justify_content
      JUSTIFY_CONTENT_VALUES = [:flex_start, :flex_end, :center, :space_between, :space_around].freeze

      ALIGN_ITEMS_KEY = :align_items
      ALIGN_ITEMS_VALUES = [:flex_start, :flex_end, :center, :baseline, :stretch].freeze

      KEYS = [FLEX_KEY, WRAP_KEY, SHRINK_KEY, GROW_KEY, ALIGN_SELF_KEY, DIRECTION_KEY, JUSTIFY_CONTENT_KEY, ALIGN_ITEMS_KEY].freeze
      RESPONSIVE_KEYS = [DIRECTION_KEY, JUSTIFY_CONTENT_KEY, ALIGN_ITEMS_KEY].freeze

      class << self
        def classes(key, value, breakpoint)
          send(key, value, breakpoint)
        end

        private

        def flex(value, _breakpoint)
          generate(
            value: value,
            allowed_values: FLEX_VALUES,
            key: FLEX_KEY,
            prefix: "flex"
          )
        end

        def flex_wrap(value, _breakpoint)
          validate(value, WRAP_MAPPINGS.keys, WRAP_KEY)

          WRAP_MAPPINGS[value]
        end

        def flex_shrink(value, _breakpoint)
          generate(
            value: value,
            allowed_values: SHRINK_VALUES,
            key: SHRINK_KEY,
            prefix: "flex-shrink"
          )
        end

        def flex_grow(value, _breakpoint)
          generate(
            value: value,
            allowed_values: GROW_VALUES,
            key: GROW_KEY,
            prefix: "flex-grow"
          )
        end

        def align_self(value, _breakpoint)
          generate(
            value: value,
            allowed_values: ALIGN_SELF_VALUES,
            key: ALIGN_SELF_KEY,
            prefix: "flex-self"
          )
        end

        def direction(value, breakpoint)
          validate(value, DIRECTION_VALUES, DIRECTION_KEY)

          "flex#{breakpoint}-#{value.to_s.dasherize}"
        end

        def justify_content(value, breakpoint)
          validate(value, JUSTIFY_CONTENT_VALUES, JUSTIFY_CONTENT_KEY)

          formatted_value = value.to_s.gsub(/(flex\_|space\_)/, "")
          "flex#{breakpoint}-justify-#{formatted_value}"
        end

        def align_items(value, breakpoint)
          validate(value, ALIGN_ITEMS_VALUES, ALIGN_ITEMS_KEY)

          formatted_value = value.to_s.gsub("flex_", "")
          "flex#{breakpoint}-items-#{formatted_value}"
        end

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
