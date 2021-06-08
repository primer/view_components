# frozen_string_literal: true

require_relative "conversion_error"
require_relative "system_arguments"

module ERBLint
  module Linters
    module ArgumentMappers
      # Maps classes in a button element to arguments for the Button component.
      class Button
        SCHEME_MAPPINGS = {
          "btn-primary" => ":primary",
          "btn-danger" => ":danger",
          "btn-outline" => ":outline",
          "btn-invisible" => ":invisible",
          "btn-link" => ":link"
        }.freeze

        VARIANT_MAPPINGS = {
          "btn-sm" => ":small",
          "btn-large" => ":large"
        }.freeze

        TYPE_OPTIONS = %w[button reset submit].freeze

        def initialize(tag)
          @tag = tag
        end

        def to_s
          to_args.map { |k, v| "#{k}: #{v}" }.join(", ")
        end

        def to_args
          args = {}

          args[:tag] = ":#{@tag.name}" unless @tag.name == "button"

          @tag.attributes.each do |attribute|
            attr_name = attribute.name

            if attr_name == "class"
              args = args.merge(classes_to_args(attribute))
            elsif attr_name == "disabled"
              args[:disabled] = true
            elsif attr_name == "type"
              # button is the default type, so we don't need to do anything.
              next if attribute.value == "button"

              raise ConversionError, "Button component does not support type \"#{attribute.value}\"" unless TYPE_OPTIONS.include?(attribute.value)

              args[:type] = ":#{attribute.value}"
            else
              # Assume the attribute is a system argument.
              args.merge!(SystemArguments.new(attribute).to_args)
            end
          end

          args
        end

        def classes_to_args(classes)
          classes.value.split(" ").each_with_object({}) do |class_name, acc|
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
