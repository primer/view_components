# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class CheckBoxGroup < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input

        @input.add_label_classes("FormControl-label", "mb-2")
        @input.add_input_classes("FormControl-check-group-wrap")

        Primer::Forms::Utils.classify(@input.input_arguments)
      end
    end
  end
end
