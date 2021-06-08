# frozen_string_literal: true

require_relative "conversion_error"

module ERBLint
  module Linters
    module ArgumentMappers
      # Maps classes in a button element to arguments for the Button component.
      class SystemArguments
        STRING_PARAETERS = %w[aria- data-].freeze

        attr_reader :attribute
        def initialize(attribute)
          @attribute = attribute
        end

        def to_args
          if attr_name == "data-test-selector"
            { test_selector: "\"#{attribute.value}\""}
          elsif attr_name.start_with?(*STRING_PARAETERS)
            # if attribute has no value_node, it means it is a boolean attribute.
            { "\"#{attr_name}\"" => attribute.value_node ? "\"#{attribute.value}\"" : true }
          else
            raise ConversionError, "Cannot convert attribute \"#{attr_name}\""
          end
        end

        def attr_name
          attribute.name
        end
      end
    end
  end
end
