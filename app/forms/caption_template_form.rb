# frozen_string_literal: true

# :nodoc:
class CaptionTemplateForm < ApplicationForm
  form do |name_form|
    name_form.text_field(
      name: :first_name,
      label: "First name",
      required: true
    )

    name_form.check_box(
      name: :cool,
      label: "Are you cool?"
    )

    name_form.radio_button_group(name: :age) do |age_radios|
      age_radios.radio_button(value: "young", label: "10-15")
      age_radios.radio_button(value: "middle_aged", label: "16-21")
    end

    name_form.check_box_group(name: "places", label: "Cool places") do |check_group|
      check_group.check_box(value: "lopez", label: "Lopez Island")
      check_group.check_box(value: "bellevue", label: "Bellevue")
      check_group.check_box(value: "seattle", label: "Seattle")
    end
  end
end
