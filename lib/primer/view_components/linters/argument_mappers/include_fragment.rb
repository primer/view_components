# frozen_string_literal: true

require_relative "base"

module ERBLint
  module Linters
    module ArgumentMappers
      # Maps attributes in the include-fragment element to arguments for the IncludeFragment component.
      class IncludeFragment < Base
        DEFAULT_TAG = "include-fragment"
        ATTRIBUTES = %w[loading src accept role preload tabindex autofocus hidden].freeze

        def attribute_to_args(attribute)
          attr_name = attribute.name

          { attr_name.to_sym => erb_helper.convert(attribute) }
        end
      end
    end
  end
end
