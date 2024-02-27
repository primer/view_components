# frozen_string_literal: true

# :nodoc:
class SelectForm < ApplicationForm
  form do |select_form|
    select_form.select_list(name: "cities", label: "Cool cities", caption: "Select your favorite!", include_blank: true) do |city_list|
      city_list.option(label: "Lopez Island", value: "lopez_island")
      city_list.option(label: "Bellevue", value: "bellevue")
      city_list.option(label: "Seattle", value: "seattle")
    end

    select_form.select_list(name: "been", label: "Places you've been", caption: "Select all that apply", multiple: true, include_hidden: false) do |been_list|
      been_list.option(label: "Lima, Peru", value: "lima")
      been_list.option(label: "Tokyo, Japan", value: "tokyo")
      been_list.option(label: "Reykjavík, Iceland", value: "reykjavik")
      been_list.option(label: "Chiang Mai, Thailand", value: "chiang_mai")
      been_list.option(label: "Queenstown, New Zealand", value: "queenstown")
    end

    select_form.submit(name: :submit, label: "Submit")
  end
end
