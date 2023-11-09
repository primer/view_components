# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class Select < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.add_input_classes(
          "FormControl-select",
          Primer::Forms::Dsl::Input::SIZE_MAPPINGS[@input.size]
        )

        @field_wrap_arguments = {
          class: class_names(
            "FormControl-select-wrap",
            Primer::Forms::Dsl::Input::WIDTH_MAPPINGS[@input.width]
          ),
          hidden: @input.hidden?
        }
      end

      def options
        @options ||= @input.options.map do |option|
          [option.label, option.value, option.system_arguments]
        end
      end
    end
  end
end
