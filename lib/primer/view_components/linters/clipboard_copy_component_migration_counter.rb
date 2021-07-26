# frozen_string_literal: true

require_relative "helpers"

module ERBLint
  module Linters
    # Counts the number of times a HTML clipboard-copy is used instead of the component.
    class ClipboardCopyComponentMigrationCounter < Linter
      include Helpers

      TAGS = %w[clipboard-copy].freeze
      CLASSES = %w[].freeze
      MESSAGE = "We are migrating clipboard-copy to use [Primer::ClipboardCopy](https://primer.style/view-components/components/clipboardcopy), please try to use that instead of raw HTML."
    end
  end
end
