# frozen_string_literal: true

module Primer
  module Alpha
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class NativeSelect < Primer::Component
      status :alpha

      DEFAULT_SIZE = :medium
      SIZE_MAPPINGS = {
        :small => "FormControl--small",
        :medium => "FormControl--medium",
        :large => "FormControl--large",
        DEFAULT_SIZE => "FormControl--medium"
      }.freeze
      SIZE_OPTIONS = SIZE_MAPPINGS.keys

      renders_one :option, lambda { |**system_arguments|
        deny_tag_argument(**system_arguments)
        system_arguments[:tag] = :option
        system_arguments[:value] = @value

        Primer::BaseComponent.new(**system_arguments)
      }

      def initialize(
        label_text: nil,
        input_id: nil,
        caption_id: "caption-#{SecureRandom.hex(4)}",
        input_name: nil,
        caption: nil,
        placeholder: nil,
        show_clear_button: false,
        visually_hide_label: nil,
        size: DEFAULT_SIZE,
        full_width: false,
        disabled: false,
        invalid: false,
        # aria_described_by: nil,

        **system_arguments
      )
        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        # this needs to push to the <select> element somehow (haaalp)
        @system_arguments[:ariaDescribedBy] = caption_id.to_s
        @label_text = label_text
        @caption = caption
        @input_id = input_id
        @caption_id = caption_id
        @input_name = input_name || input_id
        @placeholder = placeholder
        @visually_hide_label = visually_hide_label ? "sr-only" : ""
        @show_clear_button = show_clear_button
        @disabled = disabled ? "disabled" : nil
        @invalid = invalid ? "true" : nil
        @size = size
        @full_width = full_width
        # @aria_described_by = @caption_id.to_s
        @field_wrap_classes = class_names(
          "FormControl-fieldWrap",
          "FormControl-fieldWrap--select",
          SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, @size, DEFAULT_SIZE)],
          "FormControl-fieldWrap--disabled": disabled,
          "FormControl-fieldWrap--invalid": invalid
        )
        @form_group_classes = class_names(
          "FormGroup",
          "FormGroup--fullWidth": full_width
        )
        @form_control_classes = class_names(
          "FormControl",
          "FormControl--select",
          @full_width && "FormControl--fullWidth",
          SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, @size, DEFAULT_SIZE)]
        )
      end
    end
  end
end
