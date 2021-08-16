# frozen_string_literal: true

require_relative "base_linter"

module ERBLint
  module Linters
    # Counts the number of times a HTML clipboard-copy is used instead of the component.
    class CloseButtonComponentMigrationCounter < Linter
      include BaseLinter

      TAGS = %w[button].freeze
      CLASSES = %w[close-button].freeze
      MESSAGE = "We are migrating close-button to use [Primer::CloseButton](https://primer.style/view-components/components/closebutton), please try to use that instead of raw HTML."
    end
  end
end
