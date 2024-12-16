# frozen_string_literal: true

require "system/test_case"

class IntegrationOpenProjectDangerConfirmationDialogTest < System::TestCase
  def test_renders_component
    visit_preview(:default)

    click_button("Click me")

    assert_selector(".DangerConfirmationDialog")
  end
end
