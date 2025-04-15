# frozen_string_literal: true

require_relative "base_linter"
require_relative "autocorrectable"
require_relative "argument_mappers/include_fragment"

module ERBLint
  module Linters
    # Counts the number of times a HTML include-fragment is used instead of the component.
    class IncludeFragmentComponentMigrationCounter < BaseLinter
      include Autocorrectable

      TAGS = %w[include-fragment].freeze
      REQUIRED_ARGUMENTS = [].freeze
      MESSAGE = "We are migrating include-fragment to use [Primer::Alpha::IncludeFragment](https://primer.style/view-components/lookbook/inspect/primer/alpha/include_fragment/default), please try to use that instead of raw HTML."
      ARGUMENT_MAPPER = ArgumentMappers::IncludeFragment
      COMPONENT = "Primer::Alpha::IncludeFragment"
    end
  end
end
