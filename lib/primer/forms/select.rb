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

        wrap_classes = ["FormControl-select-wrap"]
        wrap_classes << Primer::Forms::Dsl::Input::INPUT_WIDTH_MAPPINGS[@input.input_width] if @input.input_width

        @field_wrap_arguments = {
          class: class_names(wrap_classes),
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
