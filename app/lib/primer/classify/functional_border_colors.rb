# frozen_string_literal: true

module Primer
  class Classify
    # Border specific functional colors
    # https://primer-css-git-mkt-color-modes-docs-primer.vercel.app/css/support/v16-migration#border
    class FunctionalBorderColors < FunctionalColors
      FUNCTIONAL_OPTIONS = {
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

      MAPPINGS = {
        gray: FUNCTIONAL_OPTIONS[:primary],
        gray_light: FUNCTIONAL_OPTIONS[:secondary],
        gray_dark: FUNCTIONAL_OPTIONS[:tertiary],
        blue: FUNCTIONAL_OPTIONS[:info],
        green: FUNCTIONAL_OPTIONS[:success],
        yellow: FUNCTIONAL_OPTIONS[:warning],
        red: FUNCTIONAL_OPTIONS[:danger],
        white: FUNCTIONAL_OPTIONS[:inverse]
      }.freeze

      OPTIONS = FUNCTIONAL_OPTIONS.values.freeze
      OPTIONS_WITHOUT_MAPPINGS = [:gray_darker, :blue_light, :red_light, :purple, :black_fade, :white_fade].freeze
      DEPRECATED_OPTIONS = [*MAPPINGS.keys, *OPTIONS_WITHOUT_MAPPINGS].freeze

      class << self
        def color(val)
          functional_color(
            key: "border",
            value: val,
            mappings: MAPPINGS,
            non_functional_prefix: "border",
            functional_prefix: "color-border",
            number_prefix: "border",
            functional_options: OPTIONS,
            options_without_mappigs: OPTIONS_WITHOUT_MAPPINGS
          )
        end
      end
    end
  end
end
