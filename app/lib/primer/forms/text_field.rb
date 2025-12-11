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

        @field_wrap_arguments = {
          class: class_names(
            "FormControl-input-baseWrap",
            "FormControl-input-wrap",
            INPUT_WRAP_SIZE[input.size],
            "FormControl-input-wrap--trailingAction": @input.show_clear_button?,
            "FormControl-input-wrap--trailingVisual": @input.trailing_visual?,
            "FormControl-input-wrap--leadingVisual": @input.leading_visual?
          ),
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

      def trailing_visual_component
        return @trailing_visual_component if defined?(@trailing_visual_component)
        visual = @input.trailing_visual

        # Render icon if specified
        @trailing_visual_component =
          if (icon_arguments = visual[:icon])
            Primer::Beta::Octicon.new(**icon_arguments)
          elsif (label_arguments = visual[:label])
            # Render label if specified
            label_arguments[:classes] = class_names(
              label_arguments.delete(:classes),
              "FormControl-input-trailingVisualLabel"
            )

            text = label_arguments.delete(:text)
            Primer::Beta::Label.new(**label_arguments).with_content(text)
          elsif (counter_arguments = visual[:counter])
            # Render counter if specified
            counter_arguments[:classes] = class_names(
              counter_arguments.delete(:classes),
              "FormControl-input-trailingVisualCounter"
            )

            Primer::Beta::Counter.new(**counter_arguments)
          elsif (text_arguments = visual[:text])
            # Render text if specified
            text_arguments[:classes] = class_names(
              text_arguments.delete(:classes),
              "FormControl-input-trailingVisualText"
            )
            text = text_arguments.delete(:text)
            Primer::Beta::Text.new(**text_arguments).with_content(text)
          end
      end
    end
  end
end
