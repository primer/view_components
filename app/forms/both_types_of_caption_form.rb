# frozen_string_literal: true

# :nodoc:
class BothTypesOfCaptionForm < ApplicationForm
  form do |caption_form|
    caption_form.text_field(
      name: :first_name,
      label: "First name",
      required: true,
      caption: "What you go by."
    )
  end
end
