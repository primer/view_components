# frozen_string_literal: true

module Primer
  class Classify
    # Border specific functional colors
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
        white: FUNCTIONAL_OPTIONS[:inverse],
        # still unsure what will happen with these colors
        gray_darker: nil,
        blue_light: nil,
        red_light: nil,
        purple: nil,
        black_fade: nil,
        white_fade: nil
      }.freeze

      OPTIONS = FUNCTIONAL_OPTIONS.values.freeze
      DEPRECATED_OPTIONS = MAPPINGS.keys.freeze

      class << self
        def color(val)
          functional_color(
            key: "border",
            value: val,
            mappings: MAPPINGS,
            non_functional_prefix: "border",
            functional_prefix: "border-",
            functional_options: OPTIONS
          )
        end
      end
    end
  end
end
