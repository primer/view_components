# frozen_string_literal: true

require "system/test_case"

class IntegrationAlphaActionBarTest < System::TestCase
  include Primer::JsTestHelpers

  def test_resizing_hides_items
    visit_preview(:default)

    assert_items_visible(count: 9)
    refute_selector("[data-target=\"action-bar.moreMenu\"]")

    page.driver.browser.resize(width: 183, height: 350)

    assert_items_visible(count: 3)
    assert_selector("[data-target=\"action-bar.moreMenu\"]")
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
    assert_items_visible(count: 2)

    page.driver.browser.keyboard.type(:tab, :left)

    assert_equal page.evaluate_script("document.activeElement.classList.contains('Button--iconOnly')"), true

    # We want to ensure that we're within the ActionMenu assert_selector("action-bar") do
    page.driver.browser.keyboard.type(:enter)
    assert_equal page.evaluate_script("document.activeElement.classList.contains('ActionListContent')"), true
  end

  def test_escape_in_overflow_menu_sets_focus_back
    visit_preview(:default)

    page.driver.browser.resize(width: 145, height: 350)
    assert_items_visible(count: 2)

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
    assert_items_visible(count: 2)

    page.driver.browser.keyboard.type(:tab, :left)

    page.driver.browser.keyboard.down(:enter)
    assert_equal page.evaluate_script("document.activeElement.classList.contains('ActionListContent')"), true

    page.driver.browser.mouse.click(x: 0, y: 0)
    page.driver.browser.keyboard.type(:tab)

    # Ensures that ActionMenu trigger is still focusable
    assert_equal page.evaluate_script("document.activeElement.classList.contains('Button--iconOnly')"), true
    assert_equal page.evaluate_script("!!document.activeElement.closest('action-menu')"), true
  end

  def test_arrow_left_loops_to_last_item
    visit_preview(:default)

    # Tab to first item and press left arrow
    page.driver.browser.keyboard.type(:tab, :left)

    # The last item "Attach" should be focused
    assert page.evaluate_script("document.activeElement.querySelector('svg.octicon-paperclip')")
  end

  def test_arrow_left_loops_to_last_item_after_resize
    visit_preview(:default)

    page.driver.browser.resize(width: 183, height: 350)
    assert_items_visible(count: 3)

    # Tab to first item and press left arrow to get to menu invoker, then last visible item
    page.driver.browser.keyboard.type(:tab, :left, :left)

    # The ActionMenu invoker button should be focused
    assert page.evaluate_script("document.activeElement.querySelector('svg.octicon-archive')")
  end

  def test_dividers_are_never_right_most_item
    # in other words, dividers are hidden when the item that immediately succeeds them is hidden

    visit_preview(:default)
    page.driver.browser.resize(width: 290, height: 350)
    assert_items_visible(count: 9)

    page.driver.browser.resize(width: 289, height: 350)
    assert_items_visible(count: 7)
  end

  def assert_items_visible(count:)
    actual_count = nil

    3.times do
      actual_count = evaluate_multiline_script(<<~JS)
        const items = document.querySelectorAll('[data-targets="action-bar.items"]');
        let count = 0;

        items.forEach((item) => {
          if (item.style.visibility === "visible") count ++;
        });

        return count;
      JS

      return true if count == actual_count

      # trigger component's #update method
      page_width, page_height = page.driver.browser.viewport_size
      page.driver.browser.resize(width: page_width + 1, height: page_height)
      page.driver.browser.resize(width: page_width - 1, height: page_height)

      sleep 0.2
    end

    assert count == actual_count, "Expected #{count} items to be visible, found #{actual_count}"
  end
end
