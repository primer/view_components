# frozen_string_literal: true

# :nodoc:
class LastNameForm < ApplicationForm
  form do |last_name_form|
    last_name_form.text_field(
      name: :last_name,
      label: "Last name",
      required: true,
      caption: "Bueller. Bueller. Bueller."
    )
  end
end
