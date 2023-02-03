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
          Primer::Forms::Dsl::Input::SIZE_MAPPINGS[@input.size]
        )

        @field_wrap_arguments = {
          class: "FormControl-select-wrap",
          hidden: @input.hidden?
        }
      end

      def options
        @options ||= @input.options.map do |option|
          [option.label, option.value, option.system_arguments]
        end
      end
    end
  end
end
