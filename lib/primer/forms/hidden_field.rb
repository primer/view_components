# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class HiddenField < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.add_input_classes("FormField-input")
      end
    end
  end
end
