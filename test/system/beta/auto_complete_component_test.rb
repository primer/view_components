# frozen_string_literal: true

require "application_system_test_case"

module Beta
  class IntegrationAutoCompleteTest < ApplicationSystemTestCase
    def test_renders_component
      visit_preview(:default)

      assert_selector("auto-complete[for=\"test-id\"][src=\"/auto_complete\"]") do
        assert_selector("input.FormControl-input")
        assert_selector("ul[id=\"test-id\"].ActionList", visible: false)
      end
      refute_selector(".ActionList-item")
    end

    def test_search_items
      visit_preview(:default)
      assert_selector("input.FormControl-input")

      fill_in "input-id", with: "a"

      # results are now visible
      assert_selector("ul[id=\"test-id\"].ActionList", visible: true)
      assert_selector(".ActionList-item")
    end

    def test_renders_non_visible_label
      visit_preview(:with_non_visible_label)

      assert_selector("label[for=\"input-id\"]", text: "Select a fruit", visible: false)
    end

    def test_renders_clear_button
      visit_preview(:show_clear_button)

      assert_selector("#input-id-clear")
    end

    def test_renders_icon
      visit_preview(:with_icon)

      assert_selector("svg.FormControl-input-leadingVisual")
    end
  end
end
