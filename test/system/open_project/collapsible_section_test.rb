# frozen_string_literal: true

require "system/test_case"

class IntegrationOpenProjectCollapsibleSectionTest < System::TestCase
  def test_renders_component
    visit_preview(:default)

    assert_selector(".CollapsibleSection")
  end

  def test_renders_collapsed
    visit_preview(:collapsed)

    assert_selector(".octicon.octicon-chevron-up.d-none", visible: false)
    assert_no_selector(".octicon.octicon-chevron-down.d-none")
    assert_no_text("Body")
  end

  def test_click_behaviour
    visit_preview(:default)

    # First, make sure it is not collapsed
    assert_no_selector(".CollapsibleSection--collapsed")
    assert_selector(".octicon.octicon-chevron-down.d-none", visible: false)
    assert_no_selector(".octicon.octicon-chevron-up.d-none")

    assert_text("Row one")

    # Collapse it
    find('.CollapsibleSection--clickArea').click

    assert_selector(".CollapsibleSection--collapsed")
    assert_selector(".octicon.octicon-chevron-up.d-none", visible: false)
    assert_no_selector(".octicon.octicon-chevron-down.d-none")

    assert_no_text("Row one")

    # Expand it again
    find('.CollapsibleSection--clickArea').click

    assert_no_selector(".CollapsibleSection--collapsed")
    assert_selector(".octicon.octicon-chevron-down.d-none", visible: false)
    assert_no_selector(".octicon.octicon-chevron-up.d-none")

    assert_text("Row one")
  end
end
