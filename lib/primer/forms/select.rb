# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class Select < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.add_input_classes("FormControl-select")

        if !input.multiple?
          @input.add_input_classes(
            Primer::Forms::Dsl::Input::SIZE_MAPPINGS[@input.size]
          )
        end

        @field_wrap_arguments = {
          class: "FormControl-select-wrap",
          hidden: @input.hidden?,
          data: { multiple: input.multiple? }
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
