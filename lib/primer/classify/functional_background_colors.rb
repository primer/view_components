# frozen_string_literal: true

require_relative "functional_colors"

module Primer
  class Classify
    # Background specific functional colors
    # https://primer-css-git-mkt-color-modes-docs-primer.vercel.app/css/support/v16-migration#background
    class FunctionalBackgroundColors < FunctionalColors
      FUNCTIONAL_OPTIONS = {
        primary: :primary,
        secondary: :secondary,
        tertiary: :tertiary,
        canvas: :canvas,
        canvas_inset: :canvas_inset,
        canvas_inverse: :canvas_inverse,
        info: :info,
        info_inverse: :info_inverse,
        success: :success,
        success_inverse: :success_inverse,
        warning: :warning,
        warning_inverse: :warning_inverse,
        danger: :danger,
        danger_inverse: :danger_inverse,
        overlay: :overlay
      }.freeze

      MAPPINGS = {
        white: FUNCTIONAL_OPTIONS[:primary],
        gray_light: FUNCTIONAL_OPTIONS[:secondary],
        gray: FUNCTIONAL_OPTIONS[:tertiary],
        gray_dark: FUNCTIONAL_OPTIONS[:canvas_inverse],
        blue_light: FUNCTIONAL_OPTIONS[:info],
        blue: FUNCTIONAL_OPTIONS[:info_inverse],
        green_light: FUNCTIONAL_OPTIONS[:success],
        green: FUNCTIONAL_OPTIONS[:success_inverse],
        yellow_light: FUNCTIONAL_OPTIONS[:warning],
        yellow: FUNCTIONAL_OPTIONS[:warning_inverse],
        red_light: FUNCTIONAL_OPTIONS[:danger],
        red: FUNCTIONAL_OPTIONS[:danger_inverse]
      }.freeze

      OPTIONS = FUNCTIONAL_OPTIONS.values.freeze
      OPTIONS_WITHOUT_MAPPINGS = [:purple_light, :purple, :yellow_dark, :orange, :pink].freeze
      DEPRECATED_OPTIONS = [*MAPPINGS.keys, *OPTIONS_WITHOUT_MAPPINGS].freeze

      class << self
        def color(val)
          functional_color(
            key: "background",
            value: val,
            mappings: MAPPINGS,
            non_functional_prefix: "bg",
            functional_prefix: "color-bg",
            number_prefix: "bg",
            functional_options: OPTIONS,
            options_without_mappigs: OPTIONS_WITHOUT_MAPPINGS
          )
        end
      end
    end
  end
end
