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

      def nested_form_arguments
        return @nested_form_arguments if defined?(@nested_form_arguments)

        @nested_form_arguments = { hidden: @input.hidden?, **@input.nested_form_arguments }
        @nested_form_arguments[:class] = class_names(
          @nested_form_arguments[:class],
          @nested_form_arguments.delete(:classes),
          "ml-4"
        )

        @nested_form_arguments
      end

      private

      def checked_value
        @input.value || "1"
      end

      def unchecked_value
        return if @input.scheme == :array

        @input.unchecked_value || "0"
      end
    end
  end
end
