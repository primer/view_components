# frozen_string_literal: true

# :nodoc:
class InvalidForm < ApplicationForm
  form do |my_form|
    my_form.text_field(
      name: :first_name,
      label: "First name",
      required: true,
      caption: "That which we call a rose by any other name would smell as sweet."
    )

    my_form.text_field(
      name: :last_name,
      label: "Last name",
      required: true,
      caption: "Bueller. Bueller. Bueller.",
      validation_message: "That doesn't look right"
    )
  end
end
