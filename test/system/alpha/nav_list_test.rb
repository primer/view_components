# frozen_string_literal: true

require "application_system_test_case"

module Alpha
  class NavListTest < ApplicationSystemTestCase
    def test_shows_more_items
      visit_preview(:show_more_item)

      # includes "Show more" item
      assert_selector "li", count: 3
      assert_selector "li", text: "Popplers"
      assert_selector "li", text: "Slurm"

      # use #find here to wait for the button to become enabled
      find("a", text: "Show more").click

      assert_selector "li", count: 4
      assert_selector "li", text: "Popplers"
      assert_selector "li", text: "Slurm"
      assert_selector "li", text: "Bachelor Chow"
      assert_selector "li", text: "LöBrau"
    end
  end
end
