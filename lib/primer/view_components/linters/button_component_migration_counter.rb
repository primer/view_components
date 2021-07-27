# frozen_string_literal: true

require_relative "helpers"
require_relative "autocorrectable"
require_relative "argument_mappers/button"

module ERBLint
  module Linters
    # Counts the number of times a HTML button is used instead of the component.
    class ButtonComponentMigrationCounter < Linter
      include Helpers
      include Autocorrectable

      TAGS = Primer::ViewComponents::Constants.get(
        component: "Primer::BaseButton",
        constant: "TAG_OPTIONS"
      ).freeze

      CLASSES = %w[btn btn-link].freeze
      MESSAGE = "We are migrating buttons to use [Primer::ButtonComponent](https://primer.style/view-components/components/button), please try to use that instead of raw HTML."
      ARGUMENT_MAPPER = ArgumentMappers::Button
      COMPONENT = "Primer::ButtonComponent"
    end
  end
end
