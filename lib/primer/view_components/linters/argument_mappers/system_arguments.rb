# frozen_string_literal: true

require_relative "conversion_error"
require_relative "helpers/erb_block"

module ERBLint
  module Linters
    module ArgumentMappers
      # Maps element attributes to system arguments.
      class SystemArguments
        STRING_PARAMETERS = %w[aria- data-].freeze
        TEST_SELECTOR_REGEX = /test_selector\((?<selector>.+)\)$/.freeze

        attr_reader :attribute, :erb_helper

        def initialize(attribute)
          @attribute = attribute
          @erb_helper = Helpers::ErbBlock.new
        end

        def to_args
          if attribute.erb?
            _, _, code_node = *attribute.node

            raise ConversionError, "Cannot convert erb block" if code_node.nil?

            code = code_node.loc.source.strip
            m = code.match(TEST_SELECTOR_REGEX)

            raise ConversionError, "Cannot convert erb block" if m.blank?

            { test_selector: m[:selector].tr("'", '"') }
          elsif attr_name == "data-test-selector"
            { test_selector: erb_helper.convert(attribute) }
          elsif attr_name.start_with?(*STRING_PARAMETERS)
            { "\"#{attr_name}\"" => erb_helper.convert(attribute) }
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
