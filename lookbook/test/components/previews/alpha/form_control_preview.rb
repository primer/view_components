# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Alpha
  # @label FormControl
  class FormControlPreview < ViewComponent::Preview
    # @label Playground
    # @param label_text text
    # @param show_clear_button toggle
    # @param visually_hide_label toggle
    # @param placeholder text
    # @param size select [small, medium, large]
    # @param label_position select [block, inline]
    # @param full_width toggle
    # @param disabled toggle
    # @param invalid toggle
    def playground(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, label_position: :block, full_width: false, disabled: false, invalid: false)
      render(Primer::Alpha::FormControl.new(label_text: label_text, input_id: "input-id", show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, label_position: label_position, full_width: full_width, disabled: disabled, invalid: invalid)) do |c|
        c.leading_visual_icon(icon: :search)
      end
    end
  end
end
