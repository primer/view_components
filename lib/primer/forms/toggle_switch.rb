# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class ToggleSwitch < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.add_label_classes("FormControl-label")
        # @input.add_input_classes("FormControl-something??")

        # @input.label_arguments[:value] = checked_value # what does this do?
      end

      private

      def checked_value
        @input.value || "1"
      end

      def unchecked_value
        @input.unchecked_value || "0"
      end
    end
  end
end
