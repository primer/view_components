# frozen_string_literal: true

# :nodoc:
class ArrayCheckBoxGroupForm < ApplicationForm
  form do |check_form|
    # Passing a name: here causes the form to emit all the check boxes with the same name.
    # In the case below, the name of each will be "places[]". If a box is checked, the
    # resulting array will contain the corresponding value.
    check_form.check_box_group(name: "places", label: "Cool places") do |check_group|
      check_group.check_box(value: "lopez", label: "Lopez Island")
      check_group.check_box(value: "bellevue", label: "Bellevue", caption: "Beautiful view")
      check_group.check_box(value: "seattle", label: "Seattle", caption: "The emerald city")
    end
  end
end
