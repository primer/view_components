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
      end
    end
  end
end
