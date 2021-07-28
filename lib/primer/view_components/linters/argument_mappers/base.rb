# frozen_string_literal: true

require "primer/view_components/constants"
require "primer/classify/utilities"
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
            if attribute.name == "class"
              args.merge!(map_classes(attribute))
            else
              args.merge!(attribute_to_args(attribute))
            end
          end

          args
        end

        def attribute_to_args(attribute); end

        def map_classes(classes)
          system_arguments = system_arguments_to_args(classes.value)
          args = classes_to_args(system_arguments[:classes])

          system_arguments.except(:classes).merge(args)
        end

        # Override this with your component's mappings
        def classes_to_args(classes)
          raise ConversionError, "Cannot convert classes" if classes.present?

          {}
        end

        def system_arguments_to_args(classes)
          system_arguments = Primer::Classify::Utilities.classes_to_hash(classes)

          # need to transform symbols to strings with leading `:`
          system_arguments.transform_values do |v|
            v.is_a?(Symbol) ? ":#{v}" : v
          end
        end
      end
    end
  end
end
