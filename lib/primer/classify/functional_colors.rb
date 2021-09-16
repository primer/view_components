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

        # @param key [String|Symbol] Option name.
        # @param value [String|Symbol] Option value.
        # @param mappings [Hash] A `color` => `functional_color` mapping hash.
        # @param non_functional_prefix [String] The prefix to use for the non-functional color classes. E.g. "text" would create "text-value".
        # @param functional_prefix [String] The prefix to use for the functional color classes. E.g. "color-text" would create "color-text-value".
        # @param number_prefix [String] The prefix to use for colors ending with number. E.g. "text" would create "text-value-1".
        # @param functional_options [Array] All the acceptable functional values.
        # @param options_without_mappigs [Array] Non functional values that don't have an associated functional color.
        def functional_color(
          key:,
          value:,
          mappings:,
          non_functional_prefix:,
          functional_options:,
          functional_prefix: "",
          number_prefix: "",
          options_without_mappigs: []
        )
          sym_value = value.to_sym
          dasherized_value = value.to_s.dasherize
          # the value is a functional color
          return "#{number_prefix}-#{dasherized_value}" if ends_with_number?(sym_value)
          return "#{functional_prefix}-#{dasherized_value}" if functional_options.include?(sym_value)
          # if the app still allows non functional colors
          return "#{non_functional_prefix}-#{dasherized_value}" unless force_functional_colors?

          if mappings.key?(sym_value) || options_without_mappigs.include?(sym_value)
            functional_color = mappings[sym_value]
            # colors without functional mapping stay the same
            return "#{non_functional_prefix}-#{dasherized_value}" if functional_color.blank?

            ActiveSupport::Deprecation.warn("#{key} #{value} is deprecated. Please use #{functional_color} instead.") unless Rails.env.production? || silence_deprecations?

            return "#{functional_prefix}-#{functional_color.to_s.dasherize}"
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

        def silence_deprecations?
          Rails.application.config.primer_view_components.silence_deprecations
        end
      end
    end
  end
end
