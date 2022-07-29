# frozen_string_literal: true

class MultiInputForm < ApplicationForm
  form do |my_form|
    my_form.radio_button_group(name: :country, label: "Country") do |radio_group|
      radio_group.radio_button(label: "USA")
      radio_group.radio_button(label: "Canada")
    end

    my_form.multi(name: :region, label: "Region") do |region|
      region.select_list(name: :state, label: "State") do |state_list|
        state_list.option(label: "California", value: "CA")
        state_list.option(label: "Washington", value: "WA")
        state_list.option(label: "Oregon", value: "OR")
      end

      region.select_list(name: :province, label: "Province", hidden: true) do |province_list|
        province_list.option(label: "British Columbia", value: "BC")
        province_list.option(label: "Alberta", value: "AB")
        province_list.option(label: "Saskatchewan", value: "SK")
      end
    end
  end
end
