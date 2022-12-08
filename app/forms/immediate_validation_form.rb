# frozen_string_literal: true

# :nodoc:
# :nocov:
class ImmediateValidationForm < ApplicationForm
  form do |validation_form|
    validation_form.text_field(
      name: :has_error,
      label: "Will have error",
      caption: "Every time this checks with the server, it returns an error",
      auto_check_src: @view_context.example_check_error_path
    )

    validation_form.text_field(
      name: :no_error,
      label: "Will not error",
      caption: "Will not have an error when it checks the server",
      auto_check_src: @view_context.example_check_ok_path,
      validation_message: "This message will go away once you type something"
    )

    validation_form.text_field(
      name: :random_error,
      label: "Random error",
      caption: "Server checks will randomly respond with errors",
      auto_check_src: @view_context.example_check_random_path
    )
  end
end
