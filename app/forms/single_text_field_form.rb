# frozen_string_literal: true

# :nodoc:
class SingleTextFieldForm < ApplicationForm
  form do |my_form|
    my_form.text_field(
      name: :ultimate_answer,
      label: "Ultimate answer",
      required: true,
      caption: "The answer to life, the universe, and everything",
      width: :narrow
    )
  end
end
