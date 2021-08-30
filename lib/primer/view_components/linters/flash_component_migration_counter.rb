# frozen_string_literal: true

require_relative "base_linter"
require_relative "autocorrectable"
require_relative "argument_mappers/flash"

module ERBLint
  module Linters
    # Counts the number of times a HTML flash is used instead of the component.
    class FlashComponentMigrationCounter < BaseLinter
      include Autocorrectable

      TAGS = %w[div].freeze
      CLASSES = %w[flash].freeze
      MESSAGE = "We are migrating flashes to use [Primer::FlashComponent](https://primer.style/view-components/components/flash), please try to use that instead of raw HTML."
      ARGUMENT_MAPPER = ArgumentMappers::Flash
      COMPONENT = "Primer::FlashComponent"

      def map_arguments(tag, tag_tree)
        # We can only autocorrect elements with simple text as content.
        return nil if tag_tree[:children].size != 1
        # Hash children indicates that there are tags in the content.
        return nil if tag_tree[:children].first.is_a?(Hash)

        ARGUMENT_MAPPER.new(tag).to_s
      rescue ArgumentMappers::ConversionError
        nil
      end
    end
  end
end
