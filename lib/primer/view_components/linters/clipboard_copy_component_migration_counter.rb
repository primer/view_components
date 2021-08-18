# frozen_string_literal: true

require_relative "helpers"
require_relative "autocorrectable"
require_relative "argument_mappers/clipboard_copy"

module ERBLint
  module Linters
    # Counts the number of times a HTML clipboard-copy is used instead of the component.
    class ClipboardCopyComponentMigrationCounter < Linter
      include Helpers
      include Autocorrectable

      TAGS = %w[clipboard-copy].freeze
      REQUIRED_ARGUMENTS = [/for|value/, "aria-label"].freeze
      MESSAGE = "We are migrating clipboard-copy to use [Primer::ClipboardCopy](https://primer.style/view-components/components/clipboardcopy), please try to use that instead of raw HTML."
      ARGUMENT_MAPPER = ArgumentMappers::ClipboardCopy
      COMPONENT = "Primer::ClipboardCopy"
    end
  end
end
