# frozen_string_literal: true

require "system/test_case"

class IntegrationOpenProjectZenModeButtonTest < System::TestCase
  def test_renders_component
    visit_preview(:default)

    assert_selector(".zen-mode-button")
  end
end
