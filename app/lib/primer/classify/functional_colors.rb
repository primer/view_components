# frozen_string_literal: true

module Primer
  class Classify
    # https://primer-css-git-mkt-color-modes-docs-primer.vercel.app/css/support/v16-migration
    class FunctionalColors
      FUNCTIONAL_TEXT_OPTIONS = {
        primary: :text_primary,
        secondary: :text_secondary,
        tertiary: :text_tertiary,
        link: :text_link,
        success: :text_success,
        warning: :text_warning,
        danger: :text_danger,
        white: :text_white,
        inverse: :text_inverse
      }.freeze

      # colors mapping to `nil` will preserve the old classes.
      # e.g. `text: :orange` will generate `text-orange`.
      TEXT_COLOR_MAPPINGS = {
        gray_dark: FUNCTIONAL_TEXT_OPTIONS[:primary],
        gray: FUNCTIONAL_TEXT_OPTIONS[:secondary],
        gray_light: FUNCTIONAL_TEXT_OPTIONS[:tertiary],
        blue: FUNCTIONAL_TEXT_OPTIONS[:link],
        green: FUNCTIONAL_TEXT_OPTIONS[:success],
        yellow: FUNCTIONAL_TEXT_OPTIONS[:warning],
        red: FUNCTIONAL_TEXT_OPTIONS[:danger],
        white: FUNCTIONAL_TEXT_OPTIONS[:white],
        # still unsure what will happen with these colors
        black: nil,
        orange: nil,
        orange_light: nil,
        purple: nil,
        pink: nil,
        inherit: nil
      }.freeze

      TEXT_OPTIONS = [
        :icon_primary,
        :icon_secondary,
        :icon_tertiary,
        :icon_info,
        :icon_success,
        :icon_warning,
        :icon_danger,
        *FUNCTIONAL_TEXT_OPTIONS.values
      ].freeze
      DEPRECATED_TEXT_OPTIONS = TEXT_COLOR_MAPPINGS.keys.freeze

      class << self
        def text_color(val)
          # the value is a functional color
          return "color-#{val.to_s.dasherize}" if ends_with_number?(val) || TEXT_OPTIONS.include?(val)
          # if the app still allows non functional colors
          return "text-#{val.to_s.dasherize}" unless force_functional_colors?

          if TEXT_COLOR_MAPPINGS.key?(val)
            functional_color = TEXT_COLOR_MAPPINGS[val]
            # colors without functional mapping stay the same
            return "text-#{val.to_s.dasherize}" if functional_color.blank?

            ActiveSupport::Deprecation.warn("Color #{val} is deprecated. Please use #{functional_color} instead.") unless Rails.env.production? || silence_color_deprecations?

            return "color-#{functional_color.to_s.dasherize}"
          end

          raise ArgumentError, "Color #{val} does not exist."
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
