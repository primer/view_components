# frozen_string_literal: true

module ERBLint
  module Linters
    module ArgumentMappers
      module Helpers
        # provides helpers to identify and deal with ERB blocks.
        class ErbBlock
          class << self
            def any?(attribute)
              attribute.value_node&.children&.any? { |n| n.try(:type) == :erb }
            end
          end
        end
      end
    end
  end
end
