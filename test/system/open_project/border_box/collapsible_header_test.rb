# frozen_string_literal: true

require "system/test_case"

class IntegrationOpenProjectCollapsibleHeaderTest < System::TestCase
  def test_renders_component
    visit_preview(:default, module_prefix: "border_box")

    assert_selector(".CollapsibleHeader")
  end

  def test_renders_collapsed
    visit_preview(:collapsed, module_prefix: "border_box")

    assert_selector(".octicon.octicon-chevron-up", visible: false)
    assert_selector(".octicon.octicon-chevron-down", visible: true)
    assert_no_text("This backlog is unique to this one-time meeting. You can drag items in and out to add or remove them from the meeting agenda.")
  end

  def test_click_behaviour
    visit_preview(:default, module_prefix: "border_box")

    trigger = find('.collapsible-header--triggerArea')

    # First, make sure it is not collapsed
    assert_no_selector(".CollapsibleHeader--collapsed")
    assert_selector(".octicon.octicon-chevron-down", visible: false)
    assert_selector(".octicon.octicon-chevron-up", visible: true)

    # Check aria-expanded is true when expanded
    assert_equal "true", trigger[:'aria-expanded']

    # Collapse it
    trigger.click

    assert_selector(".CollapsibleHeader--collapsed")
    assert_selector(".octicon.octicon-chevron-up", visible: false)
    assert_selector(".octicon.octicon-chevron-down", visible: true)

    assert_equal "false", trigger[:'aria-expanded']

    # Expand it again
    trigger.click

    assert_no_selector(".CollapsibleHeader--collapsed")
    assert_selector(".octicon.octicon-chevron-down", visible: false)
    assert_selector(".octicon.octicon-chevron-up", visible: true)

    # aria-expanded should be true again
    trigger = find('.collapsible-header--triggerArea')
    assert_equal "true", trigger[:'aria-expanded']
  end
end
