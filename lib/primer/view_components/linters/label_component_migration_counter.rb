# frozen_string_literal: true

require_relative "helpers"

module ERBLint
  module Linters
    # Counts the number of times a HTML label is used instead of the component.
    class LabelComponentMigrationCounter < Linter
      include Helpers

      TAGS = %w[span summary a div].freeze
      CLASSES = %w[Label].freeze
      MESSAGE = "We are migrating labels to use [Primer::LabelComponent](https://primer.style/view-components/components/label), please try to use that instead of raw HTML."
    end
  end
end
