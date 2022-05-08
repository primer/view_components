# frozen_string_literal: true

module Primer
  module Alpha
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class Checkbox < Primer::Component
      status :alpha

      DEFAULT_SIZE = :medium
      SIZE_MAPPINGS = {
        :small => "FormControl--small",
        :medium => "FormControl--medium",
        :large => "FormControl--large",
        DEFAULT_SIZE => "FormControl--medium"
      }.freeze
      SIZE_OPTIONS = SIZE_MAPPINGS.keys

      DEFAULT_LABEL_POSITION = :block
      LABEL_POSITION_MAPPINGS = {
        :inline => "FormGroup--inline",
        DEFAULT_LABEL_POSITION => ""
      }.freeze
      LABEL_POSITION_OPTIONS = LABEL_POSITION_MAPPINGS.keys

      renders_one :leading_visual, types: {
        icon: lambda { |**system_arguments|
          system_arguments[:classes] = class_names("FormControl-leadingVisual")
          Primer::OcticonComponent.new(**system_arguments)
        }
      }

      def initialize(
        label_text: nil,
        input_id: nil,
        input_name: nil,
        visually_hide_label: false,
        label_position: DEFAULT_LABEL_POSITION,
        disabled: false,
        invalid: false,
        type: "text",

        **system_arguments
      )
        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @label_text = label_text
        @input_id = input_id
        @input_name = input_name || input_id
        @visually_hide_label = visually_hide_label ? "sr-only" : nil
        @disabled = disabled ? "disabled" : nil
        @invalid = invalid ? "true" : nil
        @label_position = label_position
        @type = type
        @field_wrap_classes = class_names(
          "FormControl-fieldWrap",
          "FormControl-fieldWrap--disabled": disabled,
          "FormControl-fieldWrap--invalid": invalid
        )
        @form_group_classes = class_names(
          LABEL_POSITION_MAPPINGS[fetch_or_fallback(LABEL_POSITION_OPTIONS, @label_position, DEFAULT_LABEL_POSITION)],
          "FormGroup",
          "FormGroup--fullWidth": full_width
        )
        @form_control_classes = class_names(
          "FormControl",
          @full_width && "FormControl--fullWidth"
        )
      end
    end
  end
end
