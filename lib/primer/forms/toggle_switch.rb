# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class ToggleSwitch < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.add_label_classes("FormControl-label")
        @input.label_arguments[:id] = label_id
        @input.add_input_aria(:labelledby, label_id)
      end

      def label_id
        @id ||= "label-#{@input.base_id}"
      end
    end
  end
end
