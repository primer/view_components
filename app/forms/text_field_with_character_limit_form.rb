# frozen_string_literal: true

# :nodoc:
class TextFieldWithCharacterLimitForm < ApplicationForm
  form do |my_form|
    my_form.text_field(
      name: :username,
      label: "Username",
      caption: "Choose a unique username",
      character_limit: 20
    )
  end
end
