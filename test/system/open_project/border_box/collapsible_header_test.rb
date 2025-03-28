# frozen_string_literal: true

require "system/test_case"

class IntegrationOpenProjectBorderBox::CollapsibleHeaderTest < System::TestCase
  def test_renders_component
    visit_preview(:default)

    assert_selector(".border-box/collapsible-header")
  end
end
