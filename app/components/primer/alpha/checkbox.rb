# frozen_string_literal: true

module Primer
  module Alpha
    class Checkbox < Primer::Component
      status :alpha

      def initialize(
        label_text: nil,
        hint_text: nil,
        input_id: nil,
        input_name: nil,
        visually_hide_label: false,
        disabled: false,
        type: "text",

        **system_arguments
      )
        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @label_text = label_text
        @hint_text = hint_text
        @input_id = input_id
        @input_name = input_name || input_id
        @visually_hide_label = visually_hide_label ? "sr-only" : nil
        @disabled = disabled ? "disabled" : nil
        @type = type
        @form_group_classes = class_names(
          "FormGroup",
          "FormGroup--formControls"
        )
        @form_control_classes = class_names(
          "FormControl"
        )
      end
    end
  end
end
