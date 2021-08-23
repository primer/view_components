# frozen_string_literal: true

require_relative "../conversion_error"

module ERBLint
  module Linters
    module ArgumentMappers
      module Helpers
        # provides helpers to identify and deal with ERB blocks.
        class ErbBlock
          INTERPOLATION_REGEX = /^<%=(?<rb>.*)%>$/.freeze

          def raise_if_erb_block(attribute)
            raise_error(attribute) if any?(attribute)
          end

          def convert(attribute)
            raise_error(attribute) unless interpolation?(attribute)

            if any?(attribute)
              convert_interpolation(attribute)
            else
              attribute.value.to_json
            end
          end

          private

          def interpolation?(attribute)
            erb_blocks(attribute).all? do |erb|
              # If the blocks does not have an indicator, it's not an interpolation.
              erb.children.to_a.compact.any? { |node| node.type == :indicator }
            end
          end

          def raise_error(attribute)
            raise ERBLint::Linters::ArgumentMappers::ConversionError, "Cannot convert attribute \"#{attribute.name}\" because its value contains an erb block"
          end

          def any?(attribute)
            erb_blocks(attribute).any?
          end

          def basic?(attribute)
            return false if erb_blocks(attribute).size != 1

            attribute.value.match?(INTERPOLATION_REGEX)
          end

          def erb_blocks(attribute)
            (attribute.value_node&.children || []).select { |n| n.try(:type) == :erb }
          end

          def convert_interpolation(attribute)
            if basic?(attribute)
              m = attribute.value.match(INTERPOLATION_REGEX)
              return m[:rb].strip
            end

            # we use `source` instead of `value` because it does not convert encoded HTML entities.
            attribute.value_node.loc.source.gsub("<%=", '#{').gsub("%>", "}")
          end
        end
      end
    end
  end
end
