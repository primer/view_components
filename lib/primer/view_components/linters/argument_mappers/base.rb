# frozen_string_literal: true

require_relative "conversion_error"
require_relative "system_arguments"

module ERBLint
  module Linters
    module ArgumentMappers
      # Maps classes in a label element to arguments for the Label component.
      class Base
        def initialize(tag)
          @tag = tag
        end

        def to_s
          to_args.map { |k, v| "#{k}: #{v}" }.join(", ")
        end
      end
    end
  end
end
