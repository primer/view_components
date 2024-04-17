# frozen_string_literal: true

require "system/test_case"

class IntegrationAlphaActionBarTest < System::TestCase
  include Primer::JsTestHelpers
  include Primer::KeyboardTestHelpers
  include Primer::MouseTestHelpers
  include Primer::WindowTestHelpers

  def test_focus_set_on_first_item
    visit_preview(:default)
    keyboard.type(:tab)

    assert_selector("action-bar") do
      # focus should be set on the first item
      assert_equal page.evaluate_script("document.activeElement.classList.contains('Button--iconOnly')"), true
    end
  end

  # firefox does not support resizing itself small enough for these tests
  if !Primer::DriverTestHelpers.firefox?
    def test_resizing_hides_items
      visit_preview(:default)

      assert_items_visible(count: 9)
      refute_selector("[data-target=\"action-bar.moreMenu\"]")

      window.resize(width: 183, height: 350)

      assert_items_visible(count: 3)
      assert_selector("[data-target=\"action-bar.moreMenu\"]")
    end

    def test_focus_set_within_overflow_menu
      visit_preview(:default)

      window.resize(width: 145, height: 350)
      assert_items_visible(count: 2)

      keyboard.type(:tab, :left)

      assert_equal page.evaluate_script("document.activeElement.classList.contains('Button--iconOnly')"), true

      # We want to ensure that we're within the ActionMenu assert_selector("action-bar") do
      keyboard.type(:enter)
      assert_equal page.evaluate_script("document.activeElement.classList.contains('ActionListContent')"), true
    end

    def test_escape_in_overflow_menu_sets_focus_back
      visit_preview(:default)

      window.resize(width: 145, height: 350)
      assert_items_visible(count: 2)

      keyboard.type(:tab, :left)

      assert_equal page.evaluate_script("!!document.activeElement.closest('action-menu')"), true

      keyboard.type(:enter)
      assert_equal page.evaluate_script("document.activeElement.classList.contains('ActionListContent')"), true

      keyboard.type(:escape)

      assert_equal page.evaluate_script("document.activeElement.classList.contains('Button--iconOnly')"), true
      assert_equal page.evaluate_script("!!document.activeElement.closest('action-menu')"), true
    end

    def test_click_outside_of_menu_sets_tabindex_back
      visit_preview(:default)

      window.resize(width: 145, height: 350)
      assert_items_visible(count: 2)

      keyboard.type(:tab, :left)

      keyboard.type(:enter)
      assert_equal page.evaluate_script("document.activeElement.classList.contains('ActionListContent')"), true

      mouse.click(x: 0, y: 0)
      keyboard.type(:tab)

      # Ensures that ActionMenu trigger is still focusable
      assert_equal page.evaluate_script("document.activeElement.classList.contains('Button--iconOnly')"), true
      assert_equal page.evaluate_script("!!document.activeElement.closest('action-menu')"), true
    end

    def test_arrow_left_loops_to_last_item_after_resize
      visit_preview(:default)

      window.resize(width: 183, height: 350)
      assert_items_visible(count: 3)

      # Tab to first item and press left arrow to get to menu invoker, then last visible item
      keyboard.type(:tab, :left, :left)

      # The ActionMenu invoker button should be focused
      assert page.evaluate_script("document.activeElement.querySelector('svg.octicon-archive')")
    end

    def test_dividers_are_never_right_most_item
      # in other words, dividers are hidden when the item that immediately succeeds them is hidden

      visit_preview(:default)
      window.resize(width: 290, height: 350)
      assert_items_visible(count: 9)

      window.resize(width: 289, height: 350)
      assert_items_visible(count: 7)
    end
  end

  def test_arrow_left_loops_to_last_item
    visit_preview(:default)

    # Tab to first item and press left arrow
    keyboard.type(:tab, :left)

    # The last item "Attach" should be focused
    assert page.evaluate_script("document.activeElement.querySelector('svg.octicon-paperclip')")
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
      page_width, page_height = window.viewport_size
      window.resize(width: page_width + 1, height: page_height)
      window.resize(width: page_width - 1, height: page_height)

      sleep 0.2
    end

    assert count == actual_count, "Expected #{count} items to be visible, found #{actual_count}"
  end
end
