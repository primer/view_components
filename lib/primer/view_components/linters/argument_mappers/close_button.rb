# frozen_string_literal: true

require_relative "base"

module ERBLint
  module Linters
    module ArgumentMappers
      # Maps classes in a close-button element to arguments for the CloseButton component.
      class CloseButton < Base
        ATTRIBUTES = %w[type].freeze

        TYPE_OPTIONS = Primer::ViewComponents::Constants.get(
          component: "Primer::Beta::CloseButton",
          constant: "TYPE_OPTIONS"
        ).freeze

        DEFAULT_TYPE = Primer::ViewComponents::Constants.get(
          component: "Primer::Beta::CloseButton",
          constant: "DEFAULT_TYPE"
        ).freeze

        DEFAULT_CLASS = "close-button"

        def attribute_to_args(attribute)
          # button is the default type, so we don't need to do anything.
          return {} if attribute.value == DEFAULT_TYPE

          raise ConversionError, "CloseButton component does not support type \"#{attribute.value}\"" unless TYPE_OPTIONS.include?(attribute.value)

          { type: ":#{attribute.value}" }
        end

        def classes_to_args(classes)
          classes.each_with_object({ classes: [] }) do |class_name, acc|
            next if class_name == DEFAULT_CLASS

            acc[:classes] << class_name
          end
        end
      end
    end
  end
end
