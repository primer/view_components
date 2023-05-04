# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationToggleSwitchTest < System::TestCase
    def setup
      ToggleSwitchController.last_request = nil
    end

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
      wait_for_spinner
      refute_selector(".ToggleSwitch--checked")
    end

    def test_click_checked_disabled
      visit_preview(:checked_disabled)

      assert_selector(".ToggleSwitch--checked")
      assert_selector(".ToggleSwitch--disabled")
      find("toggle-switch").click
      wait_for_spinner
      assert_selector(".ToggleSwitch--checked")
    end

    def test_submits_correct_value_when_off
      visit_preview(:default)

      refute_selector(".ToggleSwitch--checked")
      find("toggle-switch").click
      assert_selector(".ToggleSwitch--checked")

      wait_for_request

      assert_equal "1", ToggleSwitchController.last_request.params[:value]
    end

    def test_submits_correct_value_when_on
      visit_preview(:checked)

      assert_selector(".ToggleSwitch--checked")
      find("toggle-switch").click
      wait_for_spinner
      refute_selector(".ToggleSwitch--checked")

      wait_for_request

      assert_equal "0", ToggleSwitchController.last_request.params[:value]
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

      wait_for_request

      assert_equal "XMLHttpRequest", ToggleSwitchController.last_request.headers["HTTP_REQUESTED_WITH"]
    end

    private

    def wait_for_spinner
      refute_selector("[data-target='toggle-switch.loadingSpinner']")
    end

    # Toggle switches switch immediately for a11y reasons, i.e. they do not wait for the
    # request to finish before toggling. We used to wait for the request by asserting the
    # checked state, but that doesn't work anymore. This method waits for the request by
    # examining ToggleSwitchController.last_request.
    def wait_for_request
      count = 0

      loop do
        break if ToggleSwitchController.last_request

        count += 1
        break if count >= 5

        sleep 1
      end
    end
  end
end
