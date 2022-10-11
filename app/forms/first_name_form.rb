# frozen_string_literal: true

# :nodoc:
class FirstNameForm < ApplicationForm
  form do |first_name_form|
    first_name_form.text_field(
      name: :first_name,
      label: "First name",
      required: true,
      caption: "That which we call a rose by any other name would smell as sweet."
    )
  end
end
