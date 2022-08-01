# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class TextArea < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.add_input_classes("FormControl-input", "FormControl--medium")
        @field_wrap_classes = class_names("FormControl-input-wrap")
      end
    end
  end
end
