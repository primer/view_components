# frozen_string_literal: true

module Primer
  class Classify
    # Text specific functional colors.
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
        white: FUNCTIONAL_OPTIONS[:white],
        # still unsure what will happen with these colors
        black: nil,
        orange: nil,
        orange_light: nil,
        purple: nil,
        pink: nil,
        inherit: nil
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
      DEPRECATED_OPTIONS = MAPPINGS.keys.freeze

      class << self
        def call(val)
          functional_color(
            key: "color",
            value: val,
            mappings: MAPPINGS,
            non_functional_prefix: "text",
            functional_options: OPTIONS
          )
        end
      end
    end
  end
end
