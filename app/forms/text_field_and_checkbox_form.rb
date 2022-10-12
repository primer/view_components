# frozen_string_literal: true

# :nodoc:
class TextFieldAndCheckboxForm < ApplicationForm
  form do |my_form|
    my_form.text_field(
      name: :ultimate_answer,
      label: "Ultimate answer",
      required: true,
      caption: "The answer to life, the universe, and everything"
    )

    my_form.check_box(
      name: :enable_ipd,
      label: "Enable the Infinite Improbability Drive",
      caption: "Cross interstellar distances in a mere nothingth of a second."
    )
  end
end
