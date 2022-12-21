# frozen_string_literal: true

require_relative "base_linter"

module ERBLint
  module Linters
    # Counts the number of times a HTML Subhead is used instead of the component.
    class SubheadComponentMigrationCounter < BaseLinter
      MESSAGE = "We are migrating Subhead to use [Primer::Beta::Subhead](https://primer.style/view-components/components/subhead), please try to use that instead of raw HTML."
      CLASSES = %w[Subhead].freeze
      TAGS = %w[div].freeze
    end
  end
end
