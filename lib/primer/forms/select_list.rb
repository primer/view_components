# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class SelectList < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.add_input_classes(
          "FormControl-select",
          "FormControl--medium"
        )

        @field_wrap_classes = class_names("FormControl-select-wrap")
      end

      def options
        @options ||= @input.options.map do |option|
          [option.label, option.value, option.system_arguments]
        end
      end
    end
  end
end
