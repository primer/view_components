# frozen_string_literal: true

require "system/test_case"

module Beta
  class IntegrationDetailsTest < System::TestCase
    include Primer::KeyboardTestHelpers

    def test_no_aria_labels_by_default_on_click
      visit_preview(:default)
      # Details is closed by default - should have no aria-label
      refute_selector(".details-overlay summary[aria-label]")
      assert_selector(".details-overlay summary", text: "Summary")

      # Open details menu
      find(".details-overlay summary").click
      # Should still have no aria-label after opening
      refute_selector(".details-overlay summary[aria-label]")
      assert_selector(".details-overlay summary", text: "Summary")

      # Close details menu
      find(".details-overlay summary").click
      # Should still have no aria-label after closing
      refute_selector(".details-overlay summary[aria-label]")
      assert_selector(".details-overlay summary", text: "Summary")
    end

    def test_no_aria_labels_by_default_keyboard
      visit_preview(:default)
      # Details is closed by default - should have no aria-label
      refute_selector(".details-overlay summary[aria-label]")
      assert_selector(".details-overlay summary", text: "Summary")

      # Open details menu
      page.evaluate_script(<<~JS)
        document.querySelector('.details-overlay summary').focus()
      JS
      keyboard.type(:enter)
      # Should still have no aria-label after opening
      refute_selector(".details-overlay summary[aria-label]")
      assert_selector(".details-overlay summary", text: "Summary")

      # Close details menu
      keyboard.type(:enter)
      # Should still have no aria-label after closing
      refute_selector(".details-overlay summary[aria-label]")
      assert_selector(".details-overlay summary", text: "Summary")
    end

    def test_aria_expanded_on_click
      visit_preview(:default)

      # Details is closed by default
      assert_selector(".details-overlay summary[aria-expanded=false]", text: "Summary")

      # Open details menu
      find(".details-overlay summary").click
      assert_selector(".details-overlay summary[aria-expanded=true]", text: "Summary")

      # Close details menu
      find(".details-overlay summary").click
      assert_selector(".details-overlay summary[aria-expanded=false]", text: "Summary")
    end

    def test_aria_expanded_keyboard
      visit_preview(:default)
      # Details is closed by default
      assert_selector(".details-overlay summary[aria-expanded=false]", text: "Summary")

      # Open details menu
      page.evaluate_script(<<~JS)
        document.querySelector('.details-overlay summary').focus()
      JS
      keyboard.type(:enter)
      assert_selector(".details-overlay summary[aria-expanded=true]", text: "Summary")

      # Close details menu
      keyboard.type(:enter)
      assert_selector(".details-overlay summary[aria-expanded=false]", text: "Summary")
    end

    def test_explicit_aria_labels_on_click
      visit_preview(:with_aria_labels)
      # Details is closed by default - should have explicit aria-label
      assert_selector(".details-overlay summary[aria-label='Expand details']", text: "Summary with aria labels")

      # Open details menu
      find(".details-overlay summary").click
      assert_selector(".details-overlay summary[aria-label='Collapse details']", text: "Summary with aria labels")

      # Close details menu
      find(".details-overlay summary").click
      assert_selector(".details-overlay summary[aria-label='Expand details']", text: "Summary with aria labels")
    end

    def test_explicit_aria_labels_keyboard
      visit_preview(:with_aria_labels)
      # Details is closed by default - should have explicit aria-label
      assert_selector(".details-overlay summary[aria-label='Expand details']", text: "Summary with aria labels")

      # Open details menu
      page.evaluate_script(<<~JS)
        document.querySelector('.details-overlay summary').focus()
      JS
      keyboard.type(:enter)
      assert_selector(".details-overlay summary[aria-label='Collapse details']", text: "Summary with aria labels")

      # Close details menu
      keyboard.type(:enter)
      assert_selector(".details-overlay summary[aria-label='Expand details']", text: "Summary with aria labels")
    end
  end
end
