# frozen_string_literal: true

require_relative "base"

module ERBLint
  module Linters
    module ArgumentMappers
      # Maps classes in a button element to arguments for the Button component.
      class Button < Base
        require "pry"

        SCHEME_MAPPINGS = Primer::ViewComponents::Constants.get(
          component: "Primer::ButtonComponent",
          constant: "SCHEME_MAPPINGS",
          symbolize: true
        ).freeze

        VARIANT_MAPPINGS = Primer::ViewComponents::Constants.get(
          component: "Primer::ButtonComponent",
          constant: "VARIANT_MAPPINGS",
          symbolize: true
        ).freeze

        TYPE_OPTIONS = Primer::ViewComponents::Constants.get(
          component: "Primer::BaseButton",
          constant: "TYPE_OPTIONS"
        ).freeze
        DEFAULT_TAG = Primer::ViewComponents::Constants.get(
          component: "Primer::BaseButton",
          constant: "DEFAULT_TAG"
        ).freeze

        def attribute_to_args(attribute)
          attr_name = attribute.name

          if attr_name == "class"
            classes_to_args(attribute)
          elsif attr_name == "disabled"
            { disabled: true }
          elsif attr_name == "type"
            # button is the default type, so we don't need to do anything.
            return {} if attribute.value == "button"

            raise ConversionError, "Button component does not support type \"#{attribute.value}\"" unless TYPE_OPTIONS.include?(attribute.value)

            { type: ":#{attribute.value}" }
          else
            # Assume the attribute is a system argument.
            SystemArguments.new(attribute).to_args
          end
        end

        def classes_to_args(classes)
          classes.split(" ").each_with_object({}) do |class_name, acc|
            next if class_name == "btn"

            if SCHEME_MAPPINGS[class_name] && acc[:scheme].nil?
              acc[:scheme] = SCHEME_MAPPINGS[class_name]
            elsif VARIANT_MAPPINGS[class_name] && acc[:variant].nil?
              acc[:variant] = VARIANT_MAPPINGS[class_name]
            elsif class_name == "btn-block"
              acc[:block] = true
            elsif class_name == "BtnGroup-item"
              acc[:group_item] = true
            else
              raise ConversionError, "Cannot convert class \"#{class_name}\""
            end
          end
        end
      end
    end
  end
end
