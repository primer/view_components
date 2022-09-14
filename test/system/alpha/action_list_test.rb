# frozen_string_literal: true

require "application_system_test_case"

module Alpha
  class ActionListTest < ApplicationSystemTestCase
    def test_changes_tabs_on_click
      visit_preview(:sub_items)

      click_button("Item one")
      assert_selector("[aria-expanded='true']")
    end
  end
end
