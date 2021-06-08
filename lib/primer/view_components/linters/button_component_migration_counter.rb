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
        ArgumentMappers::Button.new(tag).to_args
      rescue ArgumentMappers::ConversionError
        nil
      end

      def message(tag)
        args = map_arguments(tag)

        return MESSAGE if args.nil?

        msg = "#{MESSAGE}\n\nTry using:\n\n<%= render Primer::ButtonComponent.new"
        msg += "(#{args})" if args.present?
        "#{msg} %>\n\nInstead of:\n"
      end
    end
  end
end
