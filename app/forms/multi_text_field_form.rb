# frozen_string_literal: true

# :nodoc:
class MultiTextFieldForm < ApplicationForm
  form do |my_form|
    my_form.text_field(
      name: :first_name,
      label: "First name",
      required: true,
      caption: "That which we call a rose by any other name would smell as sweet.",
      width: :narrow
    )

    my_form.separator

    my_form.text_field(
      name: :last_name,
      label: "Last name",
      required: true,
      caption: "Bueller. Bueller. Bueller.",
      width: :half
    )

    my_form.hidden(
      name: :csrf_token,
      value: "abc123"
    )
  end
end
