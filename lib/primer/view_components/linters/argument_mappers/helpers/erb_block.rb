# frozen_string_literal: true

require_relative "../conversion_error"

module ERBLint
  module Linters
    module ArgumentMappers
      module Helpers
        # provides helpers to identify and deal with ERB blocks.
        class ErbBlock
          class << self
            def raise_if_erb_block(attribute)
              raise ERBLint::Linters::ArgumentMappers::ConversionError, "Cannot convert attribute \"#{attribute.name}\" because its value contains an erb block" if any?(attribute)
            end

            def any?(attribute)
              attribute.value_node&.children&.any? { |n| n.try(:type) == :erb }
            end
          end
        end
      end
    end
  end
end
