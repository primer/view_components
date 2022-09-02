# frozen_string_literal: true

require "primer/view_components/constants"
require "primer/classify/utilities"
require "primer/classify/validation"
require_relative "conversion_error"
require_relative "system_arguments"
require_relative "helpers/erb_block"

module ERBLint
  module Linters
    module ArgumentMappers
      # Provides the base interface to implement an `ArgumentMapper`.
      # Override attribute_to_args in a child class to customize its mapping behavior.
      class Base
        DEFAULT_TAG = nil
        ATTRIBUTES = [].freeze

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
            attr_name = attribute.name

            if self.class::ATTRIBUTES.include?(attr_name)
              args.merge!(attribute_to_args(attribute))
            elsif attr_name == "class"
              args.merge!(map_classes(attribute))
            else
              # Assume the attribute is a system argument.
              args.merge!(SystemArguments.new(attribute).to_args)
            end
          end

          args
        end

        def attribute_to_args(attribute); end

        def map_classes(classes_node)
          erb_helper.raise_if_erb_block(classes_node)

          system_arguments = system_arguments_to_args(classes_node.value)
          args = classes_to_args(system_arguments[:classes]&.split || [])

          invalid_classes = args[:classes].select { |class_name| Primer::Classify::Validation.invalid?(class_name) }

          raise ConversionError, "Cannot convert #{'class'.pluralize(invalid_classes.size)} #{invalid_classes.join(',')}" if invalid_classes.present?

          # Using splat to order the arguments in Component's args -> System Args -> custom classes
          res = {
            **args.except(:classes),
            **system_arguments.except(:classes)
          }

          if args[:classes].present?
            res = {
              **res,
              classes: args[:classes].join(" ").to_json
            }
          end

          res
        end

        # Override this with your component's mappings, it should return a hash with the component's arguments,
        # including a `classes` key that will contain all classes that the mapper couldn't handle.
        # @return { classes: Array, ... }
        def classes_to_args(classes)
          { classes: classes }
        end

        def system_arguments_to_args(classes)
          system_arguments = Primer::Classify::Utilities.classes_to_hash(classes)

          # need to transform symbols to strings with leading `:`
          system_arguments.transform_values do |v|
            v.is_a?(Symbol) ? ":#{v}" : v
          end
        end

        private

        def erb_helper
          @erb_helper ||= Helpers::ErbBlock.new
        end
      end
    end
  end
end
