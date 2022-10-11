# frozen_string_literal: true

# :nodoc:
class AfterContentForm < ApplicationForm
  form do |after_content_form|
    after_content_form.text_field(
      name: :first_name,
      label: "First name",
      required: true,
      caption: "What you go by."
    )
  end
end
