# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationDialogTest < System::TestCase
    def click_on_initial_dialog_close_button
      find("button[data-close-dialog-id='dialog-one']").trigger("click")
    end

    def click_on_nested_dialog_close_button
      find("button[data-close-dialog-id='dialog-two']").click
    end

    def click_on_nested_dialog_button
      find("#dialog-show-dialog-two").click
    end

    def test_modal_has_accessible_name
      visit_preview(:default)

      click_button("Show Dialog")

      assert_selector("dialog[aria-labelledby]")
      assert_equal(find("dialog")["aria-labelledby"], find("h1")["id"])
    end

    def test_focuses_close_button
      visit_preview(:default)

      click_button("Show Dialog")

      assert_equal page.evaluate_script("document.activeElement")["aria-label"], "Close"
    end

    def test_focuses_autofocus_elements_inside_dialog
      visit_preview(:autofocus_element)

      click_button("Show Dialog")

      assert_equal page.evaluate_script("document.activeElement")["placeholder"], "This element is focused on open"
    end

    def test_closes_top_level_dialog
      visit_preview(:nested_dialog)

      click_button("Show Dialog")
      click_on_nested_dialog_button

      assert_equal(find("dialog#dialog-two")["open"], true)

      click_on_nested_dialog_close_button

      assert_selector "dialog#dialog-two", visible: :hidden
      assert_selector "dialog#dialog-one"
    end

    def test_closes_dialog_that_is_not_top_level
      visit_preview(:nested_dialog)

      click_button("Show Dialog")
      click_on_nested_dialog_button

      assert_equal(find("dialog#dialog-two")["open"], true)

      click_on_initial_dialog_close_button

      assert_selector "dialog#dialog-one", visible: :hidden
    end

    # We're just opening the dialog with a scrollable body
    # so the Axe scan can ensure the scrollable region is compliant
    def test_with_scrollable_body
      visit_preview(:long_text)
      click_button("Show Dialog")
    end

    def test_outside_click_closes_dialog
      visit_preview(:default)

      click_button("Show Dialog")
      page.driver.browser.mouse.click(x: 0, y: 0)

      refute_selector "dialog[open]"
    end

    def test_outside_menu_click_does_not_close_dialog
      visit_preview(:with_auto_complete)

      click_button("Show Dialog")
      fill_in "input", with: "a"

      find(".ActionListItem", text: "Avocado").click
      assert_selector "dialog[open]"
    end
  end
end
