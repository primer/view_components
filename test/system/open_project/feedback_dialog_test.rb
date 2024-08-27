# frozen_string_literal: true

require "system/test_case"

class IntegrationOpenProjectFeedbackDialogTest < System::TestCase
  def test_renders_component
    visit_preview(:default)

    click_button("Click me")

    assert_selector(".FeedbackDialog")
  end
end
