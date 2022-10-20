# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationToggleSwitchTest < System::TestCase
    def test_click
      visit_preview(:default)

      refute_selector(".ToggleSwitch--checked")
      find("toggle-switch").click
      assert_selector(".ToggleSwitch--checked")
    end

    def test_click_disabled
      visit_preview(:disabled)

      refute_selector(".ToggleSwitch--checked")
      find("toggle-switch").click
      refute_selector(".ToggleSwitch--checked")
    end

    def test_click_checked_disabled
      visit_preview(:checked_disabled)

      assert_selector(".ToggleSwitch--checked")
      assert_selector(".ToggleSwitch--disabled")
      find("toggle-switch").click
      assert_selector(".ToggleSwitch--checked")
    end

    def test_csrf_token
      visit_preview(:with_csrf_token)

      refute_selector(".ToggleSwitch--checked")
      find("toggle-switch").click
      assert_selector(".ToggleSwitch--checked")
    end

    def test_bad_csrf_token
      visit_preview(:with_bad_csrf_token)

      refute_selector(".ToggleSwitch--checked")
      find("toggle-switch").click
      assert_selector("[data-target='toggle-switch.errorIcon']")
    end

    def test_fetch_made_with_correct_headers
      visit_preview(:default)

      refute_selector(".ToggleSwitch--checked")
      find("toggle-switch").click
      assert_selector(".ToggleSwitch--checked")

      assert_equal "XMLHttpRequest", ToggleSwitchController.last_request.headers["HTTP_REQUESTED_WITH"]
    end
  end
end
