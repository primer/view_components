# frozen_string_literal: true

require "system/test_case"

class IntegrationAlphaActionBarTest < System::TestCase
  def test_resizing_hides_items
    visit_preview(:default)

    assert_selector("action-bar") do
      assert_selector("[data-targets=\"action-bar.items\"]", count: 9)
      refute_selector("[data-target=\"action-bar.moreMenu\"]")
    end

    page.driver.browser.resize(width: 183, height: 350)

    assert_selector("action-bar") do
      assert_selector("[data-targets=\"action-bar.items\"]", count: 4)
      assert_selector("[data-target=\"action-bar.moreMenu\"]")
    end
  end
end
