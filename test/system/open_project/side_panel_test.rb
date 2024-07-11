# frozen_string_literal: true

require "system/test_case"

class IntegrationOpenProjectSidePanelTest < System::TestCase
  def test_renders_component
    visit_preview(:default)

    assert_selector(".SidePanel")
  end
end
