# frozen_string_literal: true

require_relative "helpers"

module ERBLint
  module Linters
    # Counts the number of times a HTML button is used instead of the component.
    class ButtonComponentMigrationCounter < Linter
      include Helpers

      TAGS = %w[button summary a].freeze
      CLASS = "btn"
      MESSAGE = "We are migrating buttons to use [Primer::ButtonComponent](https://primer.style/view-components/components/button), please try to use that instead of raw HTML."
    end
  end
end
