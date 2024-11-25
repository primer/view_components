# frozen_string_literal: true

# :nodoc:
class HorizontalForm < ApplicationForm
  form do |my_form|
    my_form.hidden(name: :token, value: "abc123")

    my_form.group(layout: :horizontal) do |name_group|
      name_group.text_field(
        name: :first_name,
        label: "First name",
        required: true,
        caption: "What your friends call you."
      )

      name_group.text_field(
        name: :last_name,
        label: "Last name",
        required: true,
        caption: "What the principal calls you."
      )
    end

    my_form.text_field(
      name: :dietary_restrictions,
      label: "Dietary restrictions",
      caption: "Any allergies?"
    )

    my_form.check_box(
      name: :email_notifications,
      label: "Send me gobs of email!",
      caption: "Check this if you enjoy getting spam."
    )
  end
end
