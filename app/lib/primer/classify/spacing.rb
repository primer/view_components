# frozen_string_literal: true

module Primer
  class Classify
    # Handler for PrimerCSS spacing classes.
    class Spacing
      BASE_OPTIONS = (0..6).to_a.freeze
      BASE_MAPPINGS = {
        my: BASE_OPTIONS,
        pb: BASE_OPTIONS,
        pl: BASE_OPTIONS,
        pr: BASE_OPTIONS,
        pt: BASE_OPTIONS,
        px: BASE_OPTIONS,
        py: BASE_OPTIONS
      }.freeze

      MARGIN_DIRECTION_OPTIONS = [*(-6..-1), *BASE_OPTIONS].freeze
      MARGIN_DIRECTION_MAPPINGS = {
        mb: MARGIN_DIRECTION_OPTIONS,
        ml: MARGIN_DIRECTION_OPTIONS,
        mr: MARGIN_DIRECTION_OPTIONS,
        mt: MARGIN_DIRECTION_OPTIONS
      }.freeze

      AUTO_OPTIONS = [*BASE_OPTIONS, :auto].freeze
      AUTO_MAPPINGS = {
        m: AUTO_OPTIONS,
        mx: AUTO_OPTIONS
      }.freeze

      RESPONSIVE_OPTIONS = [*BASE_OPTIONS, :responsive].freeze
      RESPONSIVE_MAPPINGS = {
        p: RESPONSIVE_OPTIONS
      }.freeze

      MAPPINGS = {
        **BASE_MAPPINGS,
        **MARGIN_DIRECTION_MAPPINGS,
        **AUTO_MAPPINGS,
        **RESPONSIVE_MAPPINGS
      }.freeze
      KEYS = MAPPINGS.keys.freeze

      class << self
        def spacing(key, val, breakpoint)
          validate(key, val) unless Rails.env.production?

          return "#{key.to_s.dasherize}#{breakpoint}-n#{val.abs}" if val.is_a?(Numeric) && val.negative?

          "#{key.to_s.dasherize}#{breakpoint}-#{val.to_s.dasherize}"
        end

        private

        def validate(key, val)
          raise ArgumentError, "#{key} is not a spacing key" unless KEYS.include?(key)
          raise ArgumentError, "#{val} is not a valid value for :#{key}. Use one of  #{MAPPINGS[key]}" unless MAPPINGS[key].include?(val)
        end
      end
    end
  end
end
