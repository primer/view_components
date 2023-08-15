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

    def test_autofocuses_close_button
      visit_preview(:default)

      click_button("Show Dialog")

      assert_selector("button[aria-label='Close'][autofocus]")
    end
  end
end
