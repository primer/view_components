# frozen_string_literal: true

require_relative "helpers"
require_relative "argument_mappers/button"

module ERBLint
  module Linters
    # Counts the number of times a HTML button is used instead of the component.
    class ButtonComponentMigrationCounter < Linter
      include Helpers

      TAGS = %w[button summary a].freeze
      CLASSES = %w[btn btn-link].freeze
      MESSAGE = "We are migrating buttons to use [Primer::ButtonComponent](https://primer.style/view-components/components/button), please try to use that instead of raw HTML."

      private

      def map_arguments(tag)
        ArgumentMappers::Button.new(tag).to_s
      rescue ArgumentMappers::ConversionError
        nil
      end

      def correction(args)
        return nil if args.nil?

        correction = "<%= render Primer::ButtonComponent.new"
        correction += "(#{args})" if args.present?
        "#{correction} do %>"
      end

      def message(args)
        return MESSAGE if args.nil?

        "#{MESSAGE}\n\nTry using:\n\n#{correction(args)}\n\nInstead of:\n"
      end
    end
  end
end
