# frozen_string_literal: true

require_relative "flex"
require_relative "functional_background_colors"
require_relative "functional_border_colors"
require_relative "grid"

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
            keys: Primer::Classify::Grid::CONTAINER_KEY,
            values: Primer::Classify::Grid::CONTAINER_VALUES
          )

          preload(
            keys: Primer::Classify::Grid::CLEARFIX_KEY,
            values: [true]
          )

          preload(
            keys: Primer::Classify::Grid::COL_KEY,
            values: Primer::Classify::Grid::COL_VALUES
          )

          preload(
            keys: [Primer::Classify::BG_KEY],
            values: Primer::Classify::FunctionalBackgroundColors::OPTIONS
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
            keys: Primer::Classify::BOX_SHADOW_KEY,
            values: [true, :small, :medium, :large, :extra_large, :none]
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
