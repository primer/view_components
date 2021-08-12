# frozen_string_literal: true

module Primer
  class Classify
    # Handler for PrimerCSS flex classes.
    class Flex
      extend Primer::FetchOrFallbackHelper

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
            prefix: "flex"
          )
        end

        def flex_shrink(value, _breakpoint)
          generate(
            value: value,
            allowed_values: SHRINK_VALUES,
            prefix: "flex-shrink"
          )
        end

        def flex_grow(value, _breakpoint)
          generate(
            value: value,
            allowed_values: GROW_VALUES,
            prefix: "flex-grow"
          )
        end

        def align_self(value, _breakpoint)
          generate(
            value: value,
            allowed_values: ALIGN_SELF_VALUES,
            prefix: "flex-self"
          )
        end

        def flex_wrap(value, _breakpoint)
          WRAP_MAPPINGS[fetch_or_fallback(WRAP_MAPPINGS.keys, value)]
        end

        def direction(value, breakpoint)
          val = fetch_or_fallback(DIRECTION_VALUES, value)

          "flex#{breakpoint}-#{val.to_s.dasherize}"
        end

        def justify_content(value, breakpoint)
          val = fetch_or_fallback(JUSTIFY_CONTENT_VALUES, value)

          formatted_value = val.to_s.gsub(/(flex_|space_)/, "")
          "flex#{breakpoint}-justify-#{formatted_value}"
        end

        def align_items(value, breakpoint)
          val = fetch_or_fallback(ALIGN_ITEMS_VALUES, value)

          formatted_value = val.to_s.gsub("flex_", "")
          "flex#{breakpoint}-items-#{formatted_value}"
        end

        def generate(value:, allowed_values:, prefix:)
          val = fetch_or_fallback(allowed_values, value)

          "#{prefix}-#{val}"
        end
      end
    end
  end
end
