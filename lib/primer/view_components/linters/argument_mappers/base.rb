# frozen_string_literal: true

require_relative "conversion_error"
require_relative "system_arguments"
require "primer/view_components/constants"

module ERBLint
  module Linters
    module ArgumentMappers
      # Provides the base interface to implement an `ArgumentMapper`.
      # To use, inherit this class and implement a `attribute_to_args(attribute)` method.
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

        def attribute_to_args(attribute); end
      end
    end
  end
end
