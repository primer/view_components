# frozen_string_literal: true

require_relative "flex"

module Primer
  class Classify
    # :nodoc:
    class AttrCache
      include Singleton

      def initialize
        @cache_enabled = true
        @lookup = {}
      end

      private :initialize

      def fetch(breakpoint, key, val)
        found = @lookup.dig(breakpoint, key, val)
        return found if found

        yield.tap do |result|
          set(result, breakpoint, key, val) if @cache_enabled
        end
      end

      def disable
        # :nocov:
        @cache_enabled = false
        yield
        @cache_enabled = true
        # :nocov:
      end

      def clear!
        @lookup.clear
      end

      def empty?
        @lookup.empty?
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

      private

      def preload(keys:, values:)
        BREAKPOINTS.each do |breakpoint|
          Array(keys).each do |key|
            values.each do |value|
              classes = Primer::Classify.send(:classes_from, key, value, breakpoint)
              set(classes, breakpoint, key, value)
            end
          end
        end
      end

      def set(item, breakpoint, key, val)
        @lookup[breakpoint] ||= {}
        @lookup[breakpoint][key] ||= {}
        @lookup[breakpoint][key][val] = item
      end
    end
  end
end
