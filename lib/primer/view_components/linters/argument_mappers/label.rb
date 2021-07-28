# frozen_string_literal: true

require_relative "base"

module ERBLint
  module Linters
    module ArgumentMappers
      # Maps classes in a label element to arguments for the Label component.
      class Label < Base
        SCHEME_MAPPINGS = Primer::ViewComponents::Constants.get(
          component: "Primer::LabelComponent",
          constant: "SCHEME_MAPPINGS",
          symbolize: true
        ).freeze

        VARIANT_MAPPINGS = Primer::ViewComponents::Constants.get(
          component: "Primer::LabelComponent",
          constant: "VARIANT_MAPPINGS",
          symbolize: true
        ).freeze

        DEFAULT_TAG = Primer::ViewComponents::Constants.get(
          component: "Primer::LabelComponent",
          constant: "DEFAULT_TAG"
        ).freeze

        ATTRIBUTES = %w[title].freeze

        def attribute_to_args(attribute)
          Helpers::ErbBlock.raise_if_erb_block(attribute)
          { title: attribute.value.to_json }
        end

        def classes_to_args(classes)
          classes.split(" ").each_with_object({}) do |class_name, acc|
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
