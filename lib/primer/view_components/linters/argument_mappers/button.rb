# frozen_string_literal: true

require_relative "base"

module ERBLint
  module Linters
    module ArgumentMappers
      # Maps classes in a button element to arguments for the Button component.
      class Button < Base
        SCHEME_MAPPINGS = Primer::ViewComponents::Constants.get(
          component: "Primer::ButtonComponent",
          constant: "SCHEME_MAPPINGS",
          symbolize: true
        ).freeze

        SIZE_MAPPINGS = Primer::ViewComponents::Constants.get(
          component: "Primer::ButtonComponent",
          constant: "SIZE_MAPPINGS",
          symbolize: true
        ).freeze

        TYPE_OPTIONS = Primer::ViewComponents::Constants.get(
          component: "Primer::Beta::BaseButton",
          constant: "TYPE_OPTIONS"
        ).freeze

        DEFAULT_TAG = Primer::ViewComponents::Constants.get(
          component: "Primer::Beta::BaseButton",
          constant: "DEFAULT_TAG"
        ).freeze

        ATTRIBUTES = %w[disabled type href name value tabindex].freeze

        def attribute_to_args(attribute)
          attr_name = attribute.name

          case attr_name
          when "disabled"
            { disabled: true }
          when "type"
            # button is the default type, so we don't need to do anything.
            return {} if attribute.value == "button"

            raise ConversionError, "Button component does not support type \"#{attribute.value}\"" unless TYPE_OPTIONS.include?(attribute.value)

            { type: ":#{attribute.value}" }
          else
            { attr_name.to_sym => erb_helper.convert(attribute) }
          end
        end

        def classes_to_args(classes)
          classes.each_with_object({ classes: [] }) do |class_name, acc|
            next if class_name == "btn"

            if SCHEME_MAPPINGS[class_name] && acc[:scheme].nil?
              acc[:scheme] = SCHEME_MAPPINGS[class_name]
            elsif SIZE_MAPPINGS[class_name] && acc[:size].nil?
              acc[:size] = SIZE_MAPPINGS[class_name]
            elsif class_name == "btn-block"
              acc[:block] = true
            elsif class_name == "BtnGroup-item"
              acc[:group_item] = true
            else
              acc[:classes] << class_name
            end
          end
        end
      end
    end
  end
end
