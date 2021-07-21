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

        def to_args
          args = {}

          args[:tag] = ":#{@tag.name}" unless @tag.name == self.class::DEFAULT_TAG

          @tag.attributes.each do |attribute|
            args.merge!(attribute_to_args(attribute))
          end

          args
        end
      end
    end
  end
end
