# frozen_string_literal: true

# :nodoc:
class SubmitButtonForm < ApplicationForm
  form do |my_form|
    my_form.fields_for(:name_form) do |builder|
      MultiTextFieldForm.new(builder)
    end

    my_form.text_field(
      name: :green,
      label: "I'm green",
      color: :success
    )

    my_form.group(layout: :horizontal) do |button_group|
      button_group.submit(name: :submit, label: "Submit", scheme: :primary, mb: 3, disabled: true) do |component|
        component.with_leading_visual_icon(icon: :"check-circle")
      end

      button_group.button(name: :button, label: "Click me", mb: 3) do |component|
        component.with_leading_visual_icon(icon: :alert)
      end
    end
  end
end
