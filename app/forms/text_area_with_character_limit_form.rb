# frozen_string_literal: true

# :nodoc:
class TextAreaWithCharacterLimitForm < ApplicationForm
  form do |my_form|
    my_form.text_area(
      name: :bio,
      label: "Bio",
      caption: "Tell us about yourself",
      character_limit: 100
    )
  end
end
