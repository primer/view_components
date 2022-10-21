# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationAutoCompleteTest < System::TestCase
    def test_renders_component
      visit_preview(:default)

      assert_selector("auto-complete[for=\"test-id\"][src=\"/auto_complete?version=alpha\"]") do
        assert_selector("input.form-control")
        assert_selector("ul[id=\"test-id\"].autocomplete-results", visible: false)
      end
      refute_selector(".autocomplete-item")
    end

    def test_search_items
      visit_preview(:default)
      assert_selector("input.form-control")

      fill_in "input-id", with: "a"

      # results are now visible
      assert_selector("ul[id=\"test-id\"].autocomplete-results", visible: true)
      assert_selector(".autocomplete-item")
    end

    def test_renders_non_visible_label
      visit_preview(:with_non_visible_label)

      assert_selector("label[for=\"input-id-1\"]", text: "Select a fruit", visible: false)
    end

    def test_renders_clear_button
      visit_preview(:with_clear_button)

      assert_selector("#input-id-4-clear")
    end

    def test_renders_icon
      visit_preview(:with_icon)

      assert_selector("svg.octicon.octicon-search")
    end
  end
end
