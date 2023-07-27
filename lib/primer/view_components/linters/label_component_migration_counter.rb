# frozen_string_literal: true

require_relative "base_linter"
require_relative "autocorrectable"
require_relative "argument_mappers/label"

module ERBLint
  module Linters
    # Counts the number of times a HTML label is used instead of the component.
    class LabelComponentMigrationCounter < BaseLinter
      include Autocorrectable

      TAGS = ::Primer::ViewComponents::Constants.get(
        component: "Primer::Beta::Label",
        constant: "TAG_OPTIONS"
      ).freeze

      CLASSES = %w[Label].freeze
      MESSAGE = "We are migrating labels to use [Primer::Beta::Label](https://primer.style/view-components/components/label), please try to use that instead of raw HTML."
      ARGUMENT_MAPPER = ArgumentMappers::Label
      COMPONENT = "Primer::Beta::Label"
    end
  end
end
