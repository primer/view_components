# frozen_string_literal: true

require_relative "base"

module ERBLint
  module Linters
    module ArgumentMappers
      # Maps classes in a label element to arguments for the Label component.
      class Label < Base
        SCHEME_MAPPINGS = {
          "Label--primary" => ":primary",
          "Label--secondary" => ":secondary",
          "Label--info" => ":info",
          "Label--success" => ":success",
          "Label--warning" => ":warning",
          "Label--danger" => ":danger",
          "Label--orange" => ":orange",
          "Label--purple" => ":purple"
        }.freeze

        VARIANT_MAPPINGS = {
          "Label--inline" => ":inline",
          "Label--large" => ":large"
        }.freeze

        DEFAULT_TAG = "span"

        def attribute_to_args(attribute)
          attr_name = attribute.name

          if attr_name == "class"
            classes_to_args(attribute)
          elsif attr_name == "title"
            { title: attribute.value }
          else
            # Assume the attribute is a system argument.
            SystemArguments.new(attribute).to_args
          end
        end

        def classes_to_args(classes)
          classes.value.split(" ").each_with_object({}) do |class_name, acc|
            next if class_name == "Label"

            if SCHEME_MAPPINGS[class_name] && acc[:scheme].nil?
              acc[:scheme] = SCHEME_MAPPINGS[class_name]
            elsif VARIANT_MAPPINGS[class_name] && acc[:variant].nil?
              acc[:variant] = VARIANT_MAPPINGS[class_name]
            else
              raise ConversionError, "Cannot convert class \"#{class_name}\""
            end
          end
        end
      end
    end
  end
end
