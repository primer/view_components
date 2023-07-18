# frozen_string_literal: true

require_relative "base"

module ERBLint
  module Linters
    module ArgumentMappers
      # Maps classes in a label element to arguments for the Label component.
      class Label < Base
        SCHEME_MAPPINGS = ::Primer::ViewComponents::Constants.get(
          component: "Primer::Beta::Label",
          constant: "SCHEME_MAPPINGS",
          symbolize: true
        ).freeze

        SIZE_MAPPINGS = ::Primer::ViewComponents::Constants.get(
          component: "Primer::Beta::Label",
          constant: "SIZE_MAPPINGS",
          symbolize: true
        ).freeze

        DEFAULT_TAG = ::Primer::ViewComponents::Constants.get(
          component: "Primer::Beta::Label",
          constant: "DEFAULT_TAG"
        ).freeze

        INLINE_CLASS = ::Primer::ViewComponents::Constants.get(
          component: "Primer::Beta::Label",
          constant: "INLINE_CLASS"
        ).freeze

        ATTRIBUTES = %w[title].freeze

        def attribute_to_args(attribute)
          { title: erb_helper.convert(attribute) }
        end

        def classes_to_args(classes)
          classes.each_with_object({ classes: [] }) do |class_name, acc|
            next if class_name == "Label"

            if SCHEME_MAPPINGS[class_name] && acc[:scheme].nil?
              acc[:scheme] = SCHEME_MAPPINGS[class_name]
            elsif SIZE_MAPPINGS[class_name] && acc[:size].nil?
              acc[:size] = SIZE_MAPPINGS[class_name]
            elsif class_name == INLINE_CLASS && acc[:inline].nil?
              acc[:inline] = true
            else
              acc[:classes] << class_name
            end
          end
        end
      end
    end
  end
end
