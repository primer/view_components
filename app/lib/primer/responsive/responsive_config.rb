# frozen_string_literal: true

module Primer
  # Module to house all responsive viewport helpers
  module Responsive
    # Configuration of responsive viewport range variant and behavior
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

      def silent_deprecation?
        Rails.env.production? || Rails.application.config.primer_view_components.silence_deprecations
      end

      # the following methods could support better configuration, if necessary
      def fallback_to_default?
        Rails.env.production?
      end

      def raise_on_invalid?
        !Rails.env.production?
      end

      module_function :silent_deprecation?, :fallback_to_default?, :raise_on_invalid?
    end
  end
end
