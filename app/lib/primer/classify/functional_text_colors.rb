# frozen_string_literal: true

module Primer
  class Classify
    # Text specific functional colors.
    # https://primer-css-git-mkt-color-modes-docs-primer.vercel.app/css/support/v16-migration#text
    class FunctionalTextColors < FunctionalColors
      FUNCTIONAL_OPTIONS = {
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
      MAPPINGS = {
        gray_dark: FUNCTIONAL_OPTIONS[:primary],
        gray: FUNCTIONAL_OPTIONS[:secondary],
        gray_light: FUNCTIONAL_OPTIONS[:tertiary],
        blue: FUNCTIONAL_OPTIONS[:link],
        green: FUNCTIONAL_OPTIONS[:success],
        yellow: FUNCTIONAL_OPTIONS[:warning],
        red: FUNCTIONAL_OPTIONS[:danger],
        white: FUNCTIONAL_OPTIONS[:white]
      }.freeze

      OPTIONS = [
        :icon_primary,
        :icon_secondary,
        :icon_tertiary,
        :icon_info,
        :icon_success,
        :icon_warning,
        :icon_danger,
        *FUNCTIONAL_OPTIONS.values
      ].freeze
      OPTIONS_WITHOUT_MAPPINGS = [:black, :orange, :orange_light, :purple, :pink, :inherit].freeze
      DEPRECATED_OPTIONS = [*MAPPINGS.keys, *OPTIONS_WITHOUT_MAPPINGS].freeze

      class << self
        def color(val)
          functional_color(
            key: "color",
            value: val,
            mappings: MAPPINGS,
            non_functional_prefix: "text",
            functional_prefix: "color",
            number_prefix: "color",
            functional_options: OPTIONS,
            options_without_mappigs: OPTIONS_WITHOUT_MAPPINGS
          )
        end
      end
    end
  end
end
