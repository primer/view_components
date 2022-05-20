# frozen_string_literal: true

module Beta
  # @label AutoComplete
  class AutoCompletePreview < ViewComponent::Preview
    # @label Playground
    # @param label_text text
    # @param show_clear_button toggle
    # @param visually_hide_label toggle
    # @param placeholder text
    # @param size select [small, medium, large]
    # @param full_width toggle
    # @param state select [error, warning]
    # @param disabled toggle
    # @param invalid toggle
    def playground(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, full_width: false, disabled: false, invalid: false)
      render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: "input-id", list_id: "test-id", src: "/auto_complete", show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, disabled: disabled, invalid: invalid)) do |c|
        c.leading_visual_icon(icon: :search)
        c.results do
          render(Primer::Beta::AutoComplete::Item.new(selected: true, value: "apple")) do |_c|
            Apple
          end
          render(Primer::Beta::AutoComplete::Item.new(value: "orange")) do |_c|
            Orange
          end
        end
      end
    end
  end
end
