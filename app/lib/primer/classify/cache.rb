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
            keys: Primer::Classify::MARGIN_DIRECTION_KEYS,
            values: [-6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6]
          )

          preload(
            keys: (Primer::Classify::SPACING_KEYS - Primer::Classify::MARGIN_DIRECTION_KEYS),
            values: [0, 1, 2, 3, 4, 5, 6]
          )

          preload(
            keys: Primer::Classify::DIRECTION_KEY,
            values: [:row, :column]
          )

          preload(
            keys: Primer::Classify::JUSTIFY_CONTENT_KEY,
            values: [:flex_start, :flex_end, :center, :space_between, :space_around]
          )

          preload(
            keys: Primer::Classify::ALIGN_ITEMS_KEY,
            values: [:flex_start, :flex_end, :center, :baseline, :stretch]
          )

          preload(
            keys: Primer::Classify::DISPLAY_KEY,
            values: [:flex, :block, :inline_block, :inline_flex, :none, :table, :table_cell]
          )

          preload(
            keys: [Primer::Classify::COLOR_KEY],
            values: [*Primer::Classify::FunctionalTextColors::OPTIONS, *Primer::Classify::FunctionalTextColors::DEPRECATED_OPTIONS]
          )

          preload(
            keys: [Primer::Classify::BG_KEY],
            values: [*Primer::Classify::FunctionalBackgroundColors::OPTIONS, *Primer::Classify::FunctionalBackgroundColors::DEPRECATED_OPTIONS]
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
            keys: Primer::Classify::FLEX_KEY,
            values: [1, :auto]
          )

          preload(
            keys: [Primer::Classify::FLEX_GROW_KEY, Primer::Classify::FLEX_SHRINK_KEY],
            values: [0]
          )

          preload(
            keys: [Primer::Classify::ALIGN_SELF_KEY],
            values: [:auto, :start, :end, :center, :baseline, :stretch]
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
