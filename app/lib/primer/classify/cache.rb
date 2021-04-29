# frozen_string_literal: true

module Primer
  class Classify
    # :nodoc:
    class Cache
      # rubocop:disable Style/MutableConstant
      LOOKUP = {}
      # rubocop:enable Style/MutableConstant

      class <<self
        def read(memo, key, val, breakpoint)
          value = LOOKUP.dig(breakpoint, key, val)
          memo[:classes] << value if value
        end

        def clear!
          LOOKUP.clear
        end

        def preload!
          preload(
            keys: Primer::Classify::Spacing::MARGIN_DIRECTION_MAPPINGS.keys,
            values: Primer::Classify::Spacing::MARGIN_DIRECTION_OPTIONS
          )

          preload(
            keys: Primer::Classify::Spacing::BASE_MAPPINGS.keys,
            values: Primer::Classify::Spacing::BASE_OPTIONS
          )

          preload(
            keys: Primer::Classify::Spacing::AUTO_MAPPINGS.keys,
            values: Primer::Classify::Spacing::AUTO_OPTIONS
          )

          preload(
            keys: Primer::Classify::Spacing::RESPONSIVE_MAPPINGS.keys,
            values: Primer::Classify::Spacing::RESPONSIVE_OPTIONS
          )

          preload(
            keys: Primer::Classify::Flex::DIRECTION_KEY,
            values: Primer::Classify::Flex::DIRECTION_VALUES
          )

          preload(
            keys: Primer::Classify::Flex::JUSTIFY_CONTENT_KEY,
            values: Primer::Classify::Flex::JUSTIFY_CONTENT_VALUES
          )

          preload(
            keys: Primer::Classify::Flex::ALIGN_ITEMS_KEY,
            values: Primer::Classify::Flex::ALIGN_ITEMS_VALUES
          )

          preload(
            keys: Primer::Classify::DISPLAY_KEY,
            values: [:flex, :block, :inline_block, :inline_flex, :none, :table, :table_cell]
          )

          preload(
            keys: [Primer::Classify::COLOR_KEY],
            values: Primer::Classify::FunctionalTextColors::OPTIONS
          )

          preload(
            keys: [Primer::Classify::BG_KEY],
            values: Primer::Classify::FunctionalBackgroundColors::OPTIONS
          )

          preload(
            keys: Primer::Classify::VERTICAL_ALIGN_KEY,
            values: [:baseline, :top, :middle, :bottom, :text_top, :text_bottom]
          )

          preload(
            keys: Primer::Classify::WORD_BREAK_KEY,
            values: [:break_all]
          )

          preload(
            keys: :text_align,
            values: [:left, :center, :right]
          )

          preload(
            keys: :font_weight,
            values: [:bold, :light, :normal]
          )

          preload(
            keys: Primer::Classify::Flex::FLEX_KEY,
            values: Primer::Classify::Flex::FLEX_VALUES
          )

          preload(
            keys: Primer::Classify::Flex::GROW_KEY,
            values: Primer::Classify::Flex::GROW_VALUES
          )

          preload(
            keys: Primer::Classify::Flex::SHRINK_KEY,
            values: Primer::Classify::Flex::SHRINK_VALUES
          )

          preload(
            keys: Primer::Classify::Flex::ALIGN_SELF_KEY,
            values: Primer::Classify::Flex::ALIGN_SELF_VALUES
          )

          preload(
            keys: [Primer::Classify::WIDTH_KEY, Primer::Classify::HEIGHT_KEY],
            values: [:fit, :fill]
          )

          preload(
            keys: Primer::Classify::BOX_SHADOW_KEY,
            values: [true, :small, :medium, :large, :extra_large, :none]
          )

          preload(
            keys: Primer::Classify::VISIBILITY_KEY,
            values: [:hidden, :visible]
          )
        end

        def preload(keys:, values:)
          BREAKPOINTS.each do |breakpoint|
            Array(keys).each do |key|
              values.each do |value|
                classes = { classes: [] }
                Primer::Classify.send(:extract_value, classes, key, value, breakpoint)

                LOOKUP[breakpoint] ||= {}
                LOOKUP[breakpoint][key] ||= {}
                LOOKUP[breakpoint][key][value] = classes[:classes].first
              end
            end
          end
        end
      end
    end
  end
end
