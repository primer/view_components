# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class TextArea < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.add_input_classes("FormControl-input", "FormControl-textarea")

        @field_wrap_arguments = {
          class: class_names("FormControl-input-wrap"),
          hidden: @input.hidden?
        }
      end

      def character_limit_validation_arguments
        {
          class: "FormControl-inlineValidation",
          id: @input.character_limit_validation_id,
          hidden: true
        }
      end
    end
  end
end
