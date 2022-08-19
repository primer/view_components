# frozen_string_literal: true

class CheckBoxGroupForm < ApplicationForm
  form do |check_form|
    check_form.check_box_group(label: "I like to eat, eat, eat:") do |check_group|
      check_group.check_box(name: "long_a", value: "long_a", label: "Ey-ples and ba-naynays", caption: 'Long "A" sound')
      check_group.check_box(name: "long_i", value: "long_i", label: "Eye-ples and ba-nainais", caption: 'Long "I" sound')
      check_group.check_box(name: "long_o", value: "long_o", label: "Oh-ples and ba-nonos", caption: 'Long "O" sound')
    end

    check_form.check_box_group(name: "places", label: "Cool places") do |check_group|
      check_group.check_box(value: "lopez", label: "Lopez Island", caption: "Vacation getaway")
      check_group.check_box(value: "bellevue", label: "Bellevue", caption: "Beautiful view")
      check_group.check_box(value: "seattle", label: "Seattle", caption: "The emerald city")
    end
  end
end
