# frozen_string_literal: true

require_relative "base"

module ERBLint
  module Linters
    module ArgumentMappers
      # Maps attributes in the clipboard-copy element to arguments for the ClipboardCopy component.
      class ClipboardCopy < Base
        DEFAULT_TAG = "clipboard-copy"
        ATTRIBUTES = %w[value].freeze

        def attribute_to_args(attribute)
          { value: erb_helper.convert(attribute) }
        end
      end
    end
  end
end
