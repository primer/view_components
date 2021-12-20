# frozen_string_literal: true

require "application_system_test_case"

class IntegrationAutocompleteTest < ApplicationSystemTestCase
  def test_renders_component
    with_preview(:default)

    assert_selector("auto-complete[for=\"test-id\"][src=\"/autocomplete\"]") do
      assert_selector("input.form-control")
      assert_selector("ul[id=\"test-id\"].autocomplete-results", visible: false)
    end
    refute_selector(".autocomplete-item")
  end

  def test_search_items
    with_preview(:default)

    fill_in "input", with: "a"

    # results are now visible
    assert_selector("ul[id=\"test-id\"].autocomplete-results", visible: true)
    assert_selector(".autocomplete-item")
  end

  def test_renders_label
    with_preview(:with_visible_label)

    assert_selector("label[for=\"input-id\"]", text: "This is a label", visible: true)
  end

  def test_renders_icon
    with_preview(:with_icon)

    assert_selector("svg.octicon.octicon-search")
  end
end
