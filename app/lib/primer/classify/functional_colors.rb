# frozen_string_literal: true

module Primer
  class Classify
    # https://primer-css-git-mkt-color-modes-docs-primer.vercel.app/css/support/v16-migration
    class FunctionalColors
      class << self
        def color(val)
          # Implemented by class' childrens.
        end

        private

        def functional_color(
          key:,
          value:,
          mappings:,
          non_functional_prefix:,
          functional_prefix: "",
          functional_options:,
          options_without_mappigs: []
        )
          # the value is a functional color
          return "color-#{functional_prefix}#{value.to_s.dasherize}" if ends_with_number?(value) || functional_options.include?(value)
          # if the app still allows non functional colors
          return "#{non_functional_prefix}-#{value.to_s.dasherize}" unless force_functional_colors?

          if mappings.key?(value) || options_without_mappigs.include?(value)
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
