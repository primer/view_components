# frozen_string_literal: true

require_relative "base_linter"

module ERBLint
  module Linters
    # Counts the number of times a HTML Blankslate is used instead of the component.
    class BlankslateComponentMigrationCounter < BaseLinter
      MESSAGE = "We are migrating Blankslate to use [Primer::Beta::Blankslate](https://primer.style/components/blankslate/rails/beta), please try to use that instead of raw HTML."
      CLASSES = %w[blankslate].freeze
      TAGS = %w[div].freeze
    end
  end
end
