# frozen_string_literal: true

require_relative "base_linter"
require_relative "autocorrectable"
require_relative "argument_mappers/flash"

module ERBLint
  module Linters
    # Counts the number of times a HTML flash is used instead of the component.
    class FlashMigrationCounter < BaseLinter
      include Autocorrectable

      TAGS = %w[div].freeze
      CLASSES = %w[flash].freeze
      MESSAGE = "We are migrating flashes to use [Primer::Alpha::Banner](https://primer.style/view-components/components/alpha/banner), please try to use that instead of raw HTML."
      ARGUMENT_MAPPER = ArgumentMappers::Flash
      COMPONENT = "Primer::Alpha::Banner"

      def map_arguments(tag, tag_tree)
        # We can only autocorrect elements with simple text as content.
        return nil if tag_tree[:children].size != 1
        # Hash children indicates that there are tags in the content.
        return nil if tag_tree[:children].first.is_a?(Hash)

        content = tag_tree[:children].first

        # Don't accept content with ERB blocks
        return nil if content.type != :text || content.children&.any? { |n| n.try(:type) == :erb }

        ARGUMENT_MAPPER.new(tag).to_s
      rescue ArgumentMappers::ConversionError
        nil
      end
    end
  end
end
