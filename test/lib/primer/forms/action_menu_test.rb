# frozen_string_literal: true

require "lib/test_helper"
require_relative "models/trip"

class Primer::Forms::ActionMenuTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_label_aria_describes_button
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |action_menu_form|
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
        end
      end
    end

    assert_selector "button[aria-describedby='Favorite city']"
  end


end
