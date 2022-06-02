# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Alpha
  # @label Checkbox
  class CheckboxPreview < ViewComponent::Preview
    # @label Playground
    # @param label_text text
    # @param caption text
    # @param disabled toggle
    # @param checked toggle
    # @param indeterminate toggle
    def playground(label_text: "Label", caption: "Hint text", disabled: false, checked: false, indeterminate: false)
      render(Primer::Alpha::Checkbox.new(label_text: label_text, caption: caption, input_id: "input-id", checked: checked, disabled: disabled, indeterminate: indeterminate))
    end

    # @label Long label
    # @display width 320px
    # @param label_text text
    # @param checked toggle
    # @param disabled toggle
    # @param indeterminate toggle
    def longlabel(label_text: "This is a very long label to demonstrate how field wraps in this very unlikely scenario", checked: false, disabled: false, indeterminate: false)
      render(Primer::Alpha::Checkbox.new(label_text: label_text, input_id: "input-id", checked: checked, disabled: disabled, indeterminate: indeterminate))
    end
  end
end
