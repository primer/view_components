# frozen_string_literal: true

require "system/test_case"

class IntegrationOpenProjectCollapsibleHeaderTest < System::TestCase
  def test_renders_component
    visit_preview(:default, module_prefix: "border_box")

    assert_selector(".CollapsibleHeader")
  end

  def test_renders_collapsed
    visit_preview(:collapsed, module_prefix: "border_box")

    assert_selector(".octicon.octicon-chevron-up.d-none", visible: false)
    assert_no_selector(".octicon.octicon-chevron-down.d-none")
    assert_no_text("This backlog is unique to this one-time meeting. You can drag items in and out to add or remove them from the meeting agenda.")
  end

  def test_click_behaviour
    visit_preview(:default, module_prefix: "border_box")

    # First, make sure it is not collapsed
    assert_no_selector(".CollapsibleHeader--collapsed")
    assert_selector(".octicon.octicon-chevron-down.d-none", visible: false)
    assert_no_selector(".octicon.octicon-chevron-up.d-none")

    # Collapse it
    find('.CollapsibleHeader').click

    assert_selector(".CollapsibleHeader--collapsed")
    assert_selector(".octicon.octicon-chevron-up.d-none", visible: false)
    assert_no_selector(".octicon.octicon-chevron-down.d-none")

    # Expand it again
    find('.CollapsibleHeader').click

    assert_no_selector(".CollapsibleHeader--collapsed")
    assert_selector(".octicon.octicon-chevron-down.d-none", visible: false)
    assert_no_selector(".octicon.octicon-chevron-up.d-none")
  end
end
