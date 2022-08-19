# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class CheckBox < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.add_label_classes("FormControl-label")
        @input.add_input_classes("FormControl-checkbox")

        return unless @input.scheme == :array

        @input.input_arguments[:multiple] = true
        @input.label_arguments[:value] = checked_value
      end

      private

      def checked_value
        @input.value || "1"
      end
    end
  end
end
