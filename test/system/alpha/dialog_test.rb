# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationDialogTest < System::TestCase
    def test_modal_has_accessible_name
      visit_preview(:default)

      click_button("Show Dialog")

      assert_selector("modal-dialog[aria-labelledby]")
      assert_equal(find("modal-dialog")["aria-labelledby"], find("h1")["id"])
    end

    def test_focuses_close_button
      visit_preview(:default)

      click_button("Show Dialog")

      assert_equal page.evaluate_script("document.activeElement")["aria-label"], "Close"
    end

    def test_focuses_autofocus_elements_inside_dialog
      visit_preview(:autofocus_element)

      click_button("Show Dialog")
    end
  end
end
