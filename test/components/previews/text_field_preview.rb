# frozen_string_literal: true

# @label Text Field Component
class TextFieldPreview < ViewComponent::Preview
  # @label Playground
  #
  # @param name text
  # @param id text
  # @param label text
  # @param show_label toggle
  # @param trailing_label text
  # @param size [Symbol] select [small, medium, large]
  # @param show_clear_button toggle
  # @param clear_button_id text
  # @param full_width toggle
  # @param disabled toggle
  # @param invalid toggle
  # @param placeholder text
  # @param inset toggle
  # @param monospace toggle
  # @param leading_visual_icon text
  def playground(
    name: "my-text-field",
    id: "my-text-field",
    label: "My text field",
    show_label: true,
    trailing_label: nil,
    size: Primer::Forms::Dsl::Input::DEFAULT_SIZE.to_s,
    show_clear_button: false,
    clear_button_id: "my-text-field-clear-button",
    full_width: false,
    disabled: false,
    invalid: false,
    placeholder: nil,
    inset: false,
    monospace: false,
    leading_visual_icon: nil
  )
    system_arguments = {
      name: name,
      id: id,
      label: label,
      show_label: show_label,
      trailing_label: trailing_label,
      size: size,
      show_clear_button: show_clear_button,
      clear_button_id: clear_button_id,
      full_width: full_width,
      disabled: disabled,
      invalid: invalid,
      placeholder: placeholder,
      inset: inset,
      monospace: monospace
    }

    if leading_visual_icon
      system_arguments[:leading_visual] = {
        icon: leading_visual_icon,
        size: :small
      }
    end

    render(Primer::TextField.new(**system_arguments))
  end
end
