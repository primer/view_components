# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class TextField < BaseComponent
      delegate :builder, :form, to: :@input

      INPUT_WRAP_SIZE = {
        small: "FormControl-input-wrap--small",
        large: "FormControl-input-wrap--large"
      }.freeze

      def initialize(input:)
        @input = input

        @input.add_input_classes(
          "FormControl-input",
          Primer::Forms::Dsl::Input::SIZE_MAPPINGS[@input.size]
        )

        wrap_classes = [
          "FormControl-input-wrap",
          INPUT_WRAP_SIZE[input.size],
          { "FormControl-input-wrap--trailingAction": @input.show_clear_button? },
          { "FormControl-input-wrap--leadingVisual": @input.leading_visual? }
        ]
        wrap_classes << Primer::Forms::Dsl::Input::INPUT_WIDTH_MAPPINGS[@input.input_width] if @input.input_width

        @field_wrap_arguments = {
          class: class_names(wrap_classes),
          hidden: @input.hidden?
        }
      end

      def auto_check_authenticity_token
        return @auto_check_authenticity_token if defined?(@auto_check_authenticity_token)

        @auto_check_authenticity_token =
          if @input.auto_check_src
            @view_context.form_authenticity_token(
              form_options: { method: :post, action: @input.auto_check_src }
            )
          end
      end
    end
  end
end
