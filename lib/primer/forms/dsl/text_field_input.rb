# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class TextFieldInput < Input
        attr_reader(
          *%i[
            name label show_clear_button leading_visual clear_button_id
            visually_hide_label inset monospace field_wrap_classes
          ]
        )

        def initialize(name:, label:, **system_arguments)
          @name = name
          @label = label

          @show_clear_button = system_arguments.delete(:show_clear_button)
          @leading_visual = system_arguments.delete(:leading_visual)
          @clear_button_id = system_arguments.delete(:clear_button_id)
          @inset = system_arguments.delete(:inset)
          @monospace = system_arguments.delete(:monospace)

          super(**system_arguments)

          add_input_classes(
            "FormControl-input",
            Primer::Forms::Dsl::Input::SIZE_MAPPINGS[size]
          )

          add_input_classes("FormControl-inset") if inset?
          add_input_classes("FormControl-monospace") if monospace?

          @field_wrap_classes = class_names(
            "FormControl-input-wrap",
            Primer::Forms::Dsl::Input::SIZE_MAPPINGS[size],
            "FormControl-input-wrap--trailingAction": show_clear_button?,
            "FormControl-input-wrap--leadingVisual": leading_visual?
          )
        end

        alias show_clear_button? show_clear_button
        alias inset? inset
        alias monospace? monospace

        def to_component
          TextField.new(input: self)
        end

        def type
          :text_field
        end

        def focusable?
          true
        end

        def leading_visual?
          !!@leading_visual
        end
      end
    end
  end
end
