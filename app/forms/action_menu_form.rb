# frozen_string_literal: true

# :nodoc:
class ActionMenuForm < ApplicationForm
  form do |action_menu_form|
    action_menu_form.action_menu(name: "city", label: "Favorite city", caption: "Select your favorite!") do |city_list|
      city_list.with_item(label: "Lopez Island", data: { value: "lopez_island" }) do |item|
        item.with_leading_visual_icon(icon: :log)
      end
      city_list.with_item(label: "Bellevue", data: { value: "bellevue" }) do |item|
        item.with_leading_visual_icon(icon: :paste)
      end
      city_list.with_item(label: "Seattle", data: { value: "seattle" }) do |item|
        item.with_leading_visual_icon(icon: :"device-camera")
      end
    end

    action_menu_form.submit(name: :submit, label: "Submit")
  end
end
