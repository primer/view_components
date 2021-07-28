# frozen_string_literal: true

require_relative "base"

module ERBLint
  module Linters
    module ArgumentMappers
      # Maps attributes in the clipboard-copy element to arguments for the ClipboardCopy component.
      class ClipboardCopy < Base
        DEFAULT_TAG = "clipboard-copy"

        def attribute_to_args(attribute)
          attr_name = attribute.name

          if attr_name == "value"
            Helpers::ErbBlock.raise_if_erb_block(attribute)

            { value: attribute.value.to_json }
          else
            # Assume the attribute is a system argument.
            SystemArguments.new(attribute).to_args
          end
        end
      end
    end
  end
end
