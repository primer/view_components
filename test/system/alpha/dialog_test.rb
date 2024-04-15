# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationDialogTest < System::TestCase
    include Primer::MouseTestHelpers

    def click_on_initial_dialog_close_button
      # this simulates capybara's #trigger method, which isn't supported with selenium drivers
      page.evaluate_script(<<~JS)
        document.querySelector("button[data-close-dialog-id='dialog-one']").dispatchEvent(new Event('click'))
      JS
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

      assert_equal(find("dialog#dialog-two")["open"].to_s, "true")

      click_on_nested_dialog_close_button

      assert_selector "dialog#dialog-two", visible: :hidden
      assert_selector "dialog#dialog-one"
    end

    def test_closes_dialog_that_is_not_top_level
      visit_preview(:nested_dialog)

      click_button("Show Dialog")
      click_on_nested_dialog_button

      assert_equal(find("dialog#dialog-two")["open"].to_s, "true")

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
      mouse.click(x: 0, y: 0)

      refute_selector "dialog[open]"
    end

    def test_outside_menu_click_does_not_close_dialog
      visit_preview(:with_auto_complete)

      click_button("Show Dialog")
      fill_in "input", with: "a"

      find(".ActionListItem", text: "Avocado").click
      assert_selector "dialog[open]"
    end

    def test_click_events_can_be_added_to_invoker_buttons
      # use this preview because it assigns a static ID to the invoker button
      visit_preview(:with_header)

      page.evaluate_script(<<~JS)
        document.querySelector('#dialog-show-my-dialog').addEventListener('click', () => {
          window.dialogInvokerClicked = true
        })
      JS

      click_button("Show Dialog")

      assert page.evaluate_script("window.dialogInvokerClicked"), "click event was not fired"
    end

    def test_dialog_inside_overlay_opens_when_clicked
      visit_preview(:dialog_inside_overlay)

      click_button("Show overlay")
      # This preview has script that automatically opens the dialog when the overlay is clicked
      assert_selector "dialog[open]"

      click_button("Cancel")

      refute_selector "dialog[open]"

      click_button("Show Dialog")

      assert_selector "dialog[open]"
    end
  end
end
