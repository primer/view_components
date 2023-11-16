# frozen_string_literal: true

# :nodoc:
class CustomWidthFieldsForm < ApplicationForm
  form do |f|
    f.text_field(
      name: :ultimate_answer,
      label: "Ultimate answer",
      required: true,
      caption: "The answer to life, the universe, and everything",
      input_width: :medium
    )

    f.select_list(
      name: "cities",
      label: "Cool cities",
      caption: "Select your favorite!",
      include_blank: true,
      input_width: :small
    ) do |city_list|
      city_list.option(label: "Lopez Island", value: "lopez_island")
      city_list.option(label: "Bellevue", value: "bellevue")
      city_list.option(label: "Seattle", value: "seattle")
    end
  end
end
