# frozen_string_literal: true

require_relative "helpers"

module ERBLint
  module Linters
    # Counts the number of times a HTML flash is used instead of the component.
    class FlashComponentMigrationCounter < Linter
      include Helpers

      TAGS = %w[div].freeze
      CLASS = "flash"
      MESSAGE = "We are migrating flashes to use [Primer::FlashComponent](https://primer.style/view-components/components/flash), please try to use that instead of raw HTML."
    end
  end
end
