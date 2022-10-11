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

    my_form.submit(name: :submit, label: "Submit", scheme: :primary, mr: 3) do |c|
      c.with_leading_visual_icon(icon: :"check-circle")
    end
  end
end
