# frozen_string_literal: true

require_relative "helpers"
require_relative "argument_mappers/button"

module Primer
  module ViewComponents
    module Linters
      # Counts the number of times a HTML button is used instead of the component.
      class ButtonComponentMigrationCounter < ERBLint::Linter
        include Helpers

        TAGS = %w[button summary a].freeze
        CLASSES = %w[btn btn-link].freeze
        MESSAGE = "We are migrating buttons to use [Primer::ButtonComponent](https://primer.style/view-components/components/button), please try to use that instead of raw HTML."

        # def run(processed_source)
        #   tags(processed_source).each do |tag|
        #     next if tag.closing?
        #     next unless TAGS&.include?(tag.name)

        #     classes = tag.attributes["class"]&.value&.split(" ")

        #     next if classes&.intersection(CLASSES).blank?

        #     generate_offense(self.class, processed_source, tag, message(tag))
        #   end

        #   counter_correct?(processed_source)
        # end

        private

        def map_arguments(tag)
          ArgumentMappers::Button.new(tag).to_args
        rescue ArgumentMappers::ConversionError
          nil
        end

        def message(tag)
          args = map_arguments(tag)

          return MESSAGE if args.nil?
          return MESSAGE + "\n<%= render Primer::ButtonComponent.new %>" if args.empty?

          MESSAGE + "\n<%= render Primer::ButtonComponent.new(#{args}) %>"
        end
      end
    end
  end
end
