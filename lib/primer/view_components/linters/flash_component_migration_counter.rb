# frozen_string_literal: true

require_relative "base_linter"

module ERBLint
  module Linters
    # Counts the number of times a HTML flash is used instead of the component.
    class FlashComponentMigrationCounter < BaseLinter
      TAGS = %w[div].freeze
      CLASSES = %w[flash].freeze
      MESSAGE = "We are migrating flashes to use [Primer::FlashComponent](https://primer.style/view-components/components/flash), please try to use that instead of raw HTML."
    end
  end
end
