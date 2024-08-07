# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class TextArea < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.add_input_classes("FormControl-input", "FormControl-textarea")

        wrap_classes = [
          "FormControl-input-wrap",
        ]

        wrap_classes << Primer::Forms::Dsl::Input::INPUT_WIDTH_MAPPINGS[@input.input_width] if @input.input_width

        @field_wrap_arguments = {
          class: class_names(wrap_classes),
          hidden: @input.hidden?
        }
      end
    end
  end
end
