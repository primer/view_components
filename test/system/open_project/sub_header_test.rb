# frozen_string_literal: true

require "system/test_case"

class IntegrationOpenProjectSubHeaderTest < System::TestCase
  def test_renders_component
    visit_preview(:default)

    assert_selector(".SubHeader")
  end

  def render_clear_button_with_an_initial_value
    visit_preview(:playground, show_clear_button: true, value: "value")

    assert_selector(".FormControl-input-wrap--trailingAction")
    assert_selector("button.FormControl-input-trailingAction")
  end

  def test_clear_button_functionality
    visit_preview(:playground, show_clear_button: true)
    # no clear button with empty value
    assert_no_selector("button.FormControl-input-trailingAction")

    fill_in "filter", with: "value"

    # Clear the field with the "x" button
    find(".FormControl-input-trailingAction").click
    assert_no_selector("button.FormControl-input-trailingAction")

    fill_in "filter", with: "value"
    assert_selector("button.FormControl-input-trailingAction")

    # Clear the field with backspace
    filter_field = find_field "filter"
    "value".length.times { filter_field.send_keys [:backspace] }
    assert_no_selector("button.FormControl-input-trailingAction")
  end
end
