# frozen_string_literal: true

require "application_system_test_case"

module Alpha
  class IntegrationToggleSwitchTest < ApplicationSystemTestCase
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
  end
end
