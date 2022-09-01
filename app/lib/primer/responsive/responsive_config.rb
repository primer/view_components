# frozen_string_literal: true

module Primer
  module Responsive
    module ResponsiveConfig
      # NOTE: optional responsive variants are skipped when
      #       calculating style classes and when validating missgin values
      RESPONSIVE_VARIANTS_MAP = {
        v_narrow: {
          style_class_modifier: "whenNarrow"
        },
        v_regular: {
          style_class_modifier: "whenRegular"
        },
        v_wide: {
          optional: true,
          style_class_modifier: "whenWide"
        }
      }.freeze

      RESPONSIVE_VARIANTS = RESPONSIVE_VARIANTS_MAP.keys.freeze
      REQUIRED_RESPONSIVE_VARIANTS = RESPONSIVE_VARIANTS_MAP.reject { |_, c| c[:optional] }.keys.freeze
    end
  end
end
