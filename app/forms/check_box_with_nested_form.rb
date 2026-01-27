# frozen_string_literal: true

# :nodoc:
class CheckBoxWithNestedForm < ApplicationForm
  # :nodoc:
  class CustomCitiesForm < ApplicationForm
    form do |custom_cities_form|
      custom_cities_form.text_field(
        name: :custom_cities,
        label: "Custom cities",
        description: "A space-separated list of cities"
      )
    end
  end

  form do |check_form|
    check_form.check_box_group(
      name: :city_categories,
      label: "City categories",
      description: "Select all that apply."
    ) do |check_group|
      check_group.check_box(
        value: "capital",
        label: "Capital",
        description: "The capital city"
      )
      check_group.check_box(
        value: "populous",
        label: "Most-populous",
        description: "The five most-populous cities"
      )
      check_group.check_box(
        value: "custom",
        label: "Custom",
        description: "A custom list of cities"
      ) do |custom_check_box|
        custom_check_box.nested_form do |builder|
          CustomCitiesForm.new(builder)
        end
      end
    end
  end
end
