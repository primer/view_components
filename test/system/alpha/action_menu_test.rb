# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationActionMenuTest < System::TestCase
    def test_dynamic_labels
      visit_preview(:single_select_with_internal_label)
      assert_selector("action-menu button[aria-controls]", text: "Menu:\nQuote reply")

      find("action-menu button[aria-controls]").click
      find("action-menu ul li:first-child").click

      assert_selector("action-menu button[aria-controls]", text: "Menu:\nCopy link")

      find("action-menu button[aria-controls]").click
      find("action-menu ul li:first-child").click

      assert_selector("action-menu button[aria-controls]", text: "Menu")
    end

    def test_anchor_align
      visit_preview(:align_end)

      find("action-menu button[aria-controls]").click

      assert_selector("anchored-position[align=end]")
    end
  end
end
