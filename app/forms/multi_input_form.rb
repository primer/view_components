# frozen_string_literal: true

# :nodoc:
class MultiInputForm < ApplicationForm
  form do |my_form|
    my_form.radio_button_group(name: :country, label: "Country") do |radio_group|
      radio_group.radio_button(label: "USA", value: "US")
      radio_group.radio_button(label: "Canada", value: "CA")
    end

    my_form.multi(name: :region, label: "Region") do |region|
      region.select_list(name: :states) do |state_list|
        state_list.option(label: "California", value: "CA")
        state_list.option(label: "Washington", value: "WA")
        state_list.option(label: "Oregon", value: "OR")
      end

      region.select_list(hidden: true, name: :provinces) do |province_list|
        province_list.option(label: "British Columbia", value: "BC")
        province_list.option(label: "Alberta", value: "AB")
        province_list.option(label: "Saskatchewan", value: "SK")
      end
    end

    my_form.submit(name: :submit, label: "Submit", scheme: :primary)
  end
end
