# frozen_string_literal: true

module Primer
  class Classify
    # :nodoc:
    class FunctionalColors
      class DeprecatedColorError < StandardError; end

      TEXT_COLOR_MAPPINGS = {
        gray_dark: :primary,
        gray: :secondary,
        gray_light: :tertiary,
        blue: :link,
        green: :success,
        yellow: :warning,
        red: :danger,
        white: :white,
        # still unsure what will happen with these colors
        black: nil,
        orange: nil,
        orange_light: nil,
        purple: nil,
        pink: nil
      }.freeze

      class << self
        def text_color(key)
          return "color-text-#{key}" if TEXT_COLOR_MAPPINGS.values.include?(key)

          if TEXT_COLOR_MAPPINGS.keys.include?(key)
            functional_color = TEXT_COLOR_MAPPINGS[key]
            # colors without functional mapping stay the same
            return "text-#{key.to_s.dasherize}" if functional_color.blank?

            raise DeprecatedColorError, "Color #{key} is deprecated. Please use #{TEXT_COLOR_MAPPINGS[key]} instead." if Rails.env.test?

            return "color-text-#{TEXT_COLOR_MAPPINGS[key]}"
          end

          raise DeprecatedColorError, "Color #{key} is deprecated and will be removed soon. Please consider using another color." if Rails.env.test?
          "text-#{key.to_s.dasherize}"
        end
      end
    end
  end
end
