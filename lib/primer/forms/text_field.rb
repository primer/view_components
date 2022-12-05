# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class TextField < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input

        @field_wrap_arguments = {
          class: class_names(
            "FormControl-input-wrap",
            Primer::Forms::Dsl::Input::SIZE_MAPPINGS[@input.size],
            "FormControl-input-wrap--trailingAction": @input.show_clear_button?,
            "FormControl-input-wrap--leadingVisual": @input.leading_visual?
          ),

          hidden: @input.hidden?
        }
      end
    end
  end
end
