# frozen_string_literal: true

# :nodoc:
class SelectForm < ApplicationForm
  form do |check_form|
    check_form.select_list(name: "cities", label: "Cool cities", caption: "Select your favorite!", include_blank: true) do |city_list|
      city_list.option(label: "Lopez Island", value: "lopez_island")
      city_list.option(label: "Bellevue", value: "bellevue")
      city_list.option(label: "Seattle", value: "seattle")
    end
  end
end
