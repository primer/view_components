# frozen_string_literal: true

require "system/test_case"

class IntegrationOpenProjectDangerDialogTest < System::TestCase
  def test_submit_button_enabled_on_dialog_open_default
    visit_preview(:default)

    click_button("Click me")

    assert_selector(".DangerDialog") do
      assert_selector("button[data-submit-dialog-id]:enabled")
    end
  end

  def test_submit_button_disabled_on_dialog_open_with_confirmation_checkbox
    visit_preview(:with_confirmation_check_box)

    click_button("Click me")

    assert_selector(".DangerDialog") do
      refute_selector("input[type='checkbox']:checked")
      refute_selector("button[data-submit-dialog-id]:enabled")
    end
  end

  def test_submit_button_enabled_when_confirmation_check_box_checked
    visit_preview(:with_confirmation_check_box)

    click_button("Click me")

    assert_selector(".DangerDialog") do
      check("I understand that this deletion cannot be reversed")
      assert_selector("button[data-submit-dialog-id]:enabled")
    end
  end

  def test_submit_button_submits_form
    visit_preview(:with_form_test, route_format: :json)

    click_button("Click me")

    assert_selector(".DangerDialog") do
      check("I understand that this deletion cannot be reversed")
      find("button[type='submit']").click

      # for some reason the JSON response is wrapped in HTML, I have no idea why
      response = JSON.parse(find("pre").text)
      assert_equal "1", response.dig("form_params", "confirm_dangerous_action")
    end
  end

  def test_submit_button_submits_form_builder_form
    visit_preview(:with_form_builder_form_test, route_format: :json)

    click_button("Click me")

    assert_selector(".DangerDialog") do
      check("I understand that this deletion cannot be reversed")
      find("button[type='submit']").click

      # for some reason the JSON response is wrapped in HTML, I have no idea why
      response = JSON.parse(find("pre").text)
      assert_equal "1", response.dig("form_params", "confirm_very_dangerous_action")
    end
  end
end
