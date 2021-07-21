# frozen_string_literal: true

require_relative "helpers"
require_relative "autocorrectable"
require_relative "argument_mappers/label"

module ERBLint
  module Linters
    # Counts the number of times a HTML label is used instead of the component.
    class LabelComponentMigrationCounter < Linter
      include Helpers
      include Autocorrectable

      TAGS = %w[span summary a div].freeze
      CLASSES = %w[Label].freeze
      MESSAGE = "We are migrating labels to use [Primer::LabelComponent](https://primer.style/view-components/components/label), please try to use that instead of raw HTML."
      ARGUMENT_MAPPER = ArgumentMappers::Label
      COMPONENT = "Primer::LabelComponent"
    end
  end
end
