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

  def test_focus_set_on_first_item
    visit_preview(:default)
    page.driver.browser.keyboard.type(:tab)

    assert_selector("action-bar") do
      # focus should be set on the first item
      assert_equal page.evaluate_script("document.activeElement.classList.contains('Button--iconOnly')"), true
    end
  end

  def test_focus_set_within_overflow_menu
    visit_preview(:default)

    page.driver.browser.resize(width: 145, height: 350)
    assert_selector("[data-targets=\"action-bar.items\"]", count: 2)

    page.driver.browser.keyboard.type(:tab, :left)

    assert_equal page.evaluate_script("document.activeElement.classList.contains('Button--iconOnly')"), true

    # We want to ensure that we're within the ActionMenu assert_selector("action-bar") do
    page.driver.browser.keyboard.type(:enter)
    assert_equal page.evaluate_script("document.activeElement.classList.contains('ActionListContent')"), true
  end

  def test_escape_in_overflow_menu_sets_focus_back
    visit_preview(:default)

    page.driver.browser.resize(width: 145, height: 350)
    assert_selector("[data-targets=\"action-bar.items\"]", count: 2)

    page.driver.browser.keyboard.type(:tab, :left)

    assert_equal page.evaluate_script("!!document.activeElement.closest('action-menu')"), true

    page.driver.browser.keyboard.down(:enter)
    assert_equal page.evaluate_script("document.activeElement.classList.contains('ActionListContent')"), true

    page.driver.browser.keyboard.down(:escape)

    assert_equal page.evaluate_script("document.activeElement.classList.contains('Button--iconOnly')"), true
    assert_equal page.evaluate_script("!!document.activeElement.closest('action-menu')"), true
  end

  def test_click_outside_of_menu_sets_tabindex_back
    visit_preview(:default)

    page.driver.browser.resize(width: 145, height: 350)
    assert_selector("[data-targets=\"action-bar.items\"]", count: 2)

    page.driver.browser.keyboard.type(:tab, :left)

    page.driver.browser.keyboard.down(:enter)
    assert_equal page.evaluate_script("document.activeElement.classList.contains('ActionListContent')"), true

    page.driver.browser.mouse.click(x: 0, y: 0)
    page.driver.browser.keyboard.type(:tab)

    # Ensures that ActionMenu trigger is still focusable
    assert_equal page.evaluate_script("document.activeElement.classList.contains('Button--iconOnly')"), true
    assert_equal page.evaluate_script("!!document.activeElement.closest('action-menu')"), true
  end
end
