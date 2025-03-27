# frozen_string_literal: true

require "system/test_case"

class IntegrationOpenProjectCollapsibleBorderBox::HeaderTest < System::TestCase
  def test_renders_component
    visit_preview(:default)

    assert_selector(".collapsible-border-box/header")
  end
end
