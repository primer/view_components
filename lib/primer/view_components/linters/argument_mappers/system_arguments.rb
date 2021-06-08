# frozen_string_literal: true

require_relative "conversion_error"

module ERBLint
  module Linters
    module ArgumentMappers
      # Maps classes in a button element to arguments for the Button component.
      class SystemArguments
        STRING_PARAETERS = %w[aria- data-].freeze
        TEST_SELECTOR_REGEX = /test_selector\((?<selector>.+)\)$/.freeze

        attr_reader :attribute
        def initialize(attribute)
          @attribute = attribute
        end

        def to_args
          if attribute.erb?
            _, _, code_node = *attribute.node

            raise ConversionError, "Cannot convert erb block" if code_node.nil?

            code = code_node.loc.source.strip
            m = code.match(TEST_SELECTOR_REGEX)

            raise ConversionError, "Cannot convert erb block" if m.blank?

            { test_selector: m[:selector].gsub("'", '"') }
          elsif attr_name == "data-test-selector"
            { test_selector: attribute.value.to_json }
          elsif attr_name.start_with?(*STRING_PARAETERS)
            # if attribute has no value_node, it means it is a boolean attribute.
            { "\"#{attr_name}\"" => attribute.value_node ? attribute.value.to_json : true }
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
