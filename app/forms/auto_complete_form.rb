# frozen_string_literal: true

require_relative "../../previews/primer/url_helpers"

# :nodoc:
class AutoCompleteForm < ApplicationForm
  form do |auto_complete_form|
    auto_complete_form.auto_complete(
      name: :fruit,
      label: "Fruit",
      caption: "Please enter your favorite fruit",
      src: Primer::UrlHelpers.autocomplete_index_path,
      validation_message: "Something went wrong"
    )

    auto_complete_form.submit(label: "Submit", name: :submit)
  end
end
