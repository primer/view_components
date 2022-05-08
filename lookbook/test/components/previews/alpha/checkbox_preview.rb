# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Alpha
  # @label Checkbox
  class CheckboxPreview < ViewComponent::Preview
    # @label Playground
    # @param label_text text
    # @param hint_text text
    # @param visually_hide_label toggle
    # @param disabled toggle
    def playground(label_text: "Label", hint_text: "Hint text", visually_hide_label: false, disabled: false)
      render(Primer::Alpha::Checkbox.new(label_text: label_text, hint_text: hint_text, input_id: "input-id", visually_hide_label: visually_hide_label, disabled: disabled))
    end

    # @label Long label
    # @display width 320px
    # @param label_text text
    # @param visually_hide_label toggle
    # @param disabled toggle
    def longlabel(label_text: "This is a very long label to demonstrate how field wraps in this very unlikely scenario", visually_hide_label: false, disabled: false)
      render(Primer::Alpha::Checkbox.new(label_text: label_text, input_id: "input-id", visually_hide_label: visually_hide_label, disabled: disabled))
    end
  end
end
