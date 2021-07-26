# frozen_string_literal: true

require_relative "conversion_error"
require_relative "system_arguments"

module ERBLint
  module Linters
    module ArgumentMappers
      # Provides the base interface to implement an `ArgumentMapper`.
      # Override attribute_to_args in a child class to customize its mapping behavior.
      class Base
        DEFAULT_TAG = nil

        def initialize(tag)
          @tag = tag
        end

        def to_s
          to_args.map { |k, v| "#{k}: #{v}" }.join(", ")
        end

        def to_args
          args = {}

          args[:tag] = ":#{@tag.name}" unless self.class::DEFAULT_TAG.nil? || @tag.name == self.class::DEFAULT_TAG

          @tag.attributes.each do |attribute|
            args.merge!(attribute_to_args(attribute))
          end

          args
        end

        def attribute_to_args(attribute)
          SystemArguments.new(attribute).to_args
        end
      end
    end
  end
end
