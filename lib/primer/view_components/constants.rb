# frozen_string_literal: true

require "json"

module Primer
  module ViewComponents
    # A module for constants that are used in the view components.
    class Constants
      CONSTANTS = JSON.parse(
        File.read(
          File.join(File.dirname(__FILE__), "../../../static/constants.json")
        )
      ).freeze

      class << self
        def get(component:, constant:, invert: true, symbolize: false)
          values = CONSTANTS.dig(component, constant)

          case values
          when Hash
            format_hash(values, invert, symbolize)
          when Array
            format_array(values, symbolize)
          else
            values
          end
        end

        private

        def format_hash(values, invert, symbolize)
          val = invert ? values.invert : values
          # remove defaults
          val = val.except("", nil)

          return val.transform_values { |v| symbolize_value(v) } if symbolize

          val
        end

        def format_array(values, symbolize)
          val = values.select(&:present?)

          return val.map { |v| symbolize_value(v) } if symbolize

          val
        end

        def symbolize_value(value)
          ":#{value}"
        end
      end
    end
  end
end
