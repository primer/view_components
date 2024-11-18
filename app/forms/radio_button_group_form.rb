# frozen_string_literal: true

# :nodoc:
class RadioButtonGroupForm < ApplicationForm
  form do |radio_form|
    radio_form.radio_button_group(
      name: "channel",
      label: "How did you hear about us?",
      caption: "We love our listeners"
    ) do |radio_group|
      radio_group.radio_button(value: "online", label: "Online advertisement", caption: "Facebook maybe?")
      radio_group.radio_button(value: "radio", label: "Radio advertisement", caption: "We love us some NPR")
      radio_group.radio_button(value: "friend", label: "From a friend", caption: "Wow, what a good person")
    end
  end
end
