# frozen_string_literal: true

require "application_system_test_case"

class IntegrationAutoCompleteTest < ApplicationSystemTestCase
  def test_renders_component
    with_preview(:default)

    assert_selector("auto-complete[for=\"test-id\"][src=\"/auto_complete\"]") do
      assert_selector("input.form-control")
      assert_selector("ul[id=\"test-id\"].autocomplete-results", visible: false)
    end
    refute_selector(".autocomplete-item")
  end

  def test_search_items
    with_preview(:default)
    assert_selector("input.form-control")

    fill_in "input-id", with: "a"

    # results are now visible
    assert_selector("ul[id=\"test-id\"].autocomplete-results", visible: true)
    assert_selector(".autocomplete-item")
  end

  def test_renders_non_visible_label
    with_preview(:with_non_visible_label)

    assert_selector("label[for=\"input-id\"]", text: "Select a fruit", visible: false)
  end

  def test_renders_icon
    with_preview(:with_icon)

    assert_selector("svg.octicon.octicon-search")
  end
end
