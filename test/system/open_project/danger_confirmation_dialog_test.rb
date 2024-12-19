# frozen_string_literal: true

require "system/test_case"

class IntegrationOpenProjectDangerConfirmationDialogTest < System::TestCase
  def test_renders_component
    visit_preview(:default)

    click_button("Click me")

    assert_selector(".DangerConfirmationDialog")
  end

  def test_submit_button_disabled_on_dialog_open
    visit_preview(:default)

    click_button("Click me")

    assert_selector(".DangerConfirmationDialog") do
      refute_selector("input[type='checkbox']:checked")
      refute_selector("button[data-submit-dialog-id]:enabled")
    end
  end

  def test_submit_button_enabled_when_confirmation_check_box_checked
    visit_preview(:default)

    click_button("Click me")

    assert_selector(".DangerConfirmationDialog") do
      check("I understand that this deletion cannot be reversed")
      assert_selector("button[data-submit-dialog-id]:enabled")
    end
  end
end
