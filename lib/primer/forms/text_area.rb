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
    end
  end
end
