module Primer
  module Forms
    module Dsl
      # :nodoc:
      class TextFieldInput < Input
        attr_reader(
          *%i[
            name label show_clear_button leading_visual leading_spinner trailing_visual clear_button_id
            visually_hide_label inset monospace field_wrap_classes auto_check_src character_limit
          ]
        )

        alias leading_spinner? leading_spinner

        def initialize(name:, label:, **system_arguments)
          @name = name
          @label = label

          @show_clear_button = system_arguments.delete(:show_clear_button)
          @leading_visual = system_arguments.delete(:leading_visual)
          @trailing_visual = system_arguments.delete(:trailing_visual)
          @leading_spinner = !!system_arguments.delete(:leading_spinner)
          @clear_button_id = system_arguments.delete(:clear_button_id) || SecureRandom.uuid
          @inset = system_arguments.delete(:inset)
          @monospace = system_arguments.delete(:monospace)
          @auto_check_src = system_arguments.delete(:auto_check_src)
          @character_limit = system_arguments.delete(:character_limit)

          if @character_limit.present? && @character_limit.to_i <= 0
            raise ArgumentError, "character_limit must be a positive integer, got #{@character_limit}"
          end

          if @leading_visual
            @leading_visual[:classes] = class_names(
              "FormControl-input-leadingVisual",
              @leading_visual[:classes]
            )
          end

          if @leading_spinner && !@leading_visual
            raise ArgumentError, "text fields that request a leading spinner must also specify a leading visual"
          end

          super(**system_arguments)

          add_input_data(:target, "primer-text-field.inputElement #{system_arguments.dig(:data, :target) || ''}")
          add_input_classes("FormControl-inset") if inset?
          add_input_classes("FormControl-monospace") if monospace?
        end

        alias show_clear_button? show_clear_button
        alias inset? inset
        alias monospace? monospace

        def trailing_visual?
          !!@trailing_visual
        end

        def leading_visual?
          !!@leading_visual
        end

        def to_component
          TextField.new(input: self)
        end

        def type
          :text_field
        end

        def focusable?
          true
        end

        def character_limit?
          @character_limit.present?
        end

        def character_limit_sr_id
          @character_limit_sr_id ||= "#{name}-character-count-sr-#{SecureRandom.hex(4)}"
        end

        def character_limit_display_id
          @character_limit_display_id ||= "#{name}-character-limit-display-#{SecureRandom.hex(4)}"
        end

        def character_limit_validation_id
          @character_limit_validation_id ||= "#{name}-character-limit-validation-#{SecureRandom.hex(4)}"
        end

        def validation_arguments
          if auto_check_src.present?
            super.merge(
              data: {
                target: "primer-text-field.validationElement"
              }
            )
          else
            super
          end
        end

        def validation_success_icon_target
          "primer-text-field.validationSuccessIcon"
        end

        def validation_error_icon_target
          "primer-text-field.validationErrorIcon"
        end

        def validation_message_arguments
          if auto_check_src.present?
            super.merge(
              data: {
                target: "primer-text-field.validationMessageElement"
              }
            )
          else
            super
          end
        end
      end
    end
  end
end
