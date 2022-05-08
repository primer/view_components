# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Alpha
  # @label Checkbox
  class CheckboxPreview < ViewComponent::Preview
    # @label Playground
    # @param label_text text
    # @param visually_hide_label toggle
    # @param placeholder text
    # @param label_position select [block, inline]
    # @param disabled toggle
    # @param invalid toggle
    def playground(label_text: "Select a fruit", visually_hide_label: false, label_position: :block, disabled: false, invalid: false)
      render(Primer::Alpha::Checkbox.new(label_text: label_text, input_id: "input-id", visually_hide_label: visually_hide_label, label_position: label_position, disabled: disabled, invalid: invalid))
    end
  end
end
