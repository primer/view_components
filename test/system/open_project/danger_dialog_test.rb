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

    assert_selector(".DangerDialog")
    within(".DangerDialog") do
      check("I understand that this deletion cannot be reversed")
      assert_selector("button[data-submit-dialog-id]:enabled")
    end
  end

  def test_playground_custom_button_text
    visit_preview(:playground, confirm_button_text: "Löschen", cancel_button_text: "Abbrechen")

    click_button("Click me")
    assert_selector(".DangerDialog")
    within(".DangerDialog") do
      assert_selector("button[data-submit-dialog-id]", text: "Löschen")
      assert_selector("button[data-close-dialog-id]", text: "Abbrechen")
    end
  end

  def test_submit_button_submits_form
    visit_preview(:with_form_test, route_format: :json)

    click_button("Click me")

    assert_selector(".DangerDialog")
    within(".DangerDialog") do
      check("I understand that this deletion cannot be reversed")
      find("button[type='submit']").click
    end

    form_params = JSON.parse(page.document.text)["form_params"]
    assert_equal "1", form_params["confirm_dangerous_action"]
  end

  def test_submit_button_submits_form_builder_form
    visit_preview(:with_form_builder_form_test, route_format: :json)

    click_button("Click me")

    assert_selector(".DangerDialog")
    within(".DangerDialog") do
      fill_in "Reason for deletion", with: "Superfluous"
      within_fieldset "Notify" do
        check "Creator"
        check "Assignee"
      end
      find("button[type='submit']").click
    end

    form_params = JSON.parse(page.document.text)["form_params"]
    assert_equal "Superfluous", form_params["reason"]
    assert_equal ["creator", "assignee"], form_params["notify"]
  end

  def test_live_region_updates_based_on_checkbox
    visit_preview(:with_confirmation_check_box)

    click_button("Click me")

    assert_selector(".DangerDialog") do
      assert_selector("[data-target='danger-dialog-form-helper.liveRegion']")

      within(".DangerDialog") do
        # Check the checkbox
        check("I understand that this deletion cannot be reversed")
      end

      # Delay a bit so that the liveRegion can update
      sleep 1

      live_region_text = page.evaluate_script(%Q|
          document.querySelector("[data-target='danger-dialog-form-helper.liveRegion']")?.shadowRoot?.querySelector('#assertive')?.textContent ?? ""
        |)
      # Live region updates when checked
      assert_equal "The button to proceed is now active.", live_region_text


      # Uncheck to verify it toggles back
      within(".DangerDialog") do
        uncheck("I understand that this deletion cannot be reversed")
      end

      # Delay a bit so that the liveRegion can update
      sleep 1

      live_region_text = page.evaluate_script(%Q|
          document.querySelector("[data-target='danger-dialog-form-helper.liveRegion']")?.shadowRoot?.querySelector('#assertive')?.textContent ?? ""
        |)
      assert_equal "The button to proceed is now inactive. You need to tick the checkbox to continue.", live_region_text
    end
  end
end
