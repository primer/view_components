# frozen_string_literal: true

module Primer
  class Classify
    # https://primer-css-git-mkt-color-modes-docs-primer.vercel.app/css/support/v16-migration
    class FunctionalColors
      FUNCTIONAL_COLOR_REGEX = /(primary|secondary|tertiary|link|success|warning|danger|info|inverse|text_white)/.freeze

      TEXT_COLOR_MAPPINGS = {
        gray_dark: :text_primary,
        gray: :text_secondary,
        gray_light: :text_tertiary,
        blue: :text_link,
        green: :text_success,
        yellow: :text_warning,
        red: :text_danger,
        white: :text_white,
        # still unsure what will happen with these colors
        black: nil,
        orange: nil,
        orange_light: nil,
        purple: nil,
        pink: nil,
        inherit: nil
      }.freeze

      class << self
        def text_color(val)
          # the value is a functional color
          return "color-#{val.to_s.dasherize}" if ends_with_number?(val) || FUNCTIONAL_COLOR_REGEX.match?(val)
          # if the app still allows non functional colors
          return "text-#{val.to_s.dasherize}" unless force_functional_colors?

          if TEXT_COLOR_MAPPINGS.key?(val)
            functional_color = TEXT_COLOR_MAPPINGS[val]
            # colors without functional mapping stay the same
            return "text-#{val.to_s.dasherize}" if functional_color.blank?

            ActiveSupport::Deprecation.warn("Color #{val} is deprecated. Please use #{functional_color} instead.") unless Rails.env.production?

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
      end
    end
  end
end
