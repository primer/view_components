# frozen_string_literal: true

module Primer
  class Classify
    # https://primer-css-git-mkt-color-modes-docs-primer.vercel.app/css/support/v16-migration
    class FunctionalColors
      FUNCTIONAL_BORDER_OPTIONS = {
        primary: :primary,
        secondary: :secondary,
        tertiary: :tertiary,
        info: :info,
        success: :success,
        warning: :warning,
        danger: :danger,
        inverse: :inverse,
        overlay: :overlay
      }.freeze

      BORDER_COLOR_MAPPINGS = {
        gray: FUNCTIONAL_BORDER_OPTIONS[:primary],
        gray_light: FUNCTIONAL_BORDER_OPTIONS[:secondary],
        gray_dark: FUNCTIONAL_BORDER_OPTIONS[:tertiary],
        blue: FUNCTIONAL_BORDER_OPTIONS[:info],
        green: FUNCTIONAL_BORDER_OPTIONS[:success],
        yellow: FUNCTIONAL_BORDER_OPTIONS[:warning],
        red: FUNCTIONAL_BORDER_OPTIONS[:danger],
        white: FUNCTIONAL_BORDER_OPTIONS[:inverse],
        # still unsure what will happen with these colors
        gray_darker: nil,
        blue_light: nil,
        red_light: nil,
        purple: nil,
        black_fade: nil,
        white_fade: nil
      }.freeze

      BORDER_OPTIONS = FUNCTIONAL_BORDER_OPTIONS.values.freeze
      DEPRECATED_BORDER_OPTIONS = BORDER_COLOR_MAPPINGS.keys.freeze

      class << self
        def border_color(val)
          functional_color(
            key: "border",
            value: val,
            mappings: BORDER_COLOR_MAPPINGS,
            non_functional_prefix: "border",
            functional_prefix: "border-",
            functional_options: BORDER_OPTIONS
          )
        end

        private

        def functional_color(key:, value:, mappings:, non_functional_prefix:, functional_options:, functional_prefix: "")
          # the value is a functional color
          return "color-#{functional_prefix}#{value.to_s.dasherize}" if ends_with_number?(value) || functional_options.include?(value)
          # if the app still allows non functional colors
          return "#{non_functional_prefix}-#{value.to_s.dasherize}" unless force_functional_colors?

          if mappings.key?(value)
            functional_color = mappings[value]
            # colors without functional mapping stay the same
            return "#{non_functional_prefix}-#{value.to_s.dasherize}" if functional_color.blank?

            ActiveSupport::Deprecation.warn("#{key} #{value} is deprecated. Please use #{functional_color} instead.") unless Rails.env.production? || silence_color_deprecations?

            return "color-#{functional_prefix}#{functional_color.to_s.dasherize}"
          end

          raise ArgumentError, "#{key} #{value} does not exist." unless Rails.env.production?
        end

        def ends_with_number?(val)
          char_code = val[-1].ord
          char_code >= 48 && char_code <= 57
        end

        def force_functional_colors?
          Rails.application.config.primer_view_components.force_functional_colors
        end

        def silence_color_deprecations?
          Rails.application.config.primer_view_components.silence_color_deprecations
        end
      end
    end
  end
end
