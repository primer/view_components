# frozen_string_literal: true

require "system/test_case"

module Beta
  class IntegrationDetailsTest < System::TestCase
    include Primer::KeyboardTestHelpers

    def test_aria_labels_on_click
      visit_preview(:default)
      # Details is closed by default
      assert_selector(".details-overlay summary[aria-label='Expand']", text: "Summary")

      # Open details menu
      find(".details-overlay summary").click
      assert_selector(".details-overlay summary[aria-label='Collapse']", text: "Summary")

      # Close details menu
      find(".details-overlay summary").click
      assert_selector(".details-overlay summary[aria-label='Expand']", text: "Summary")
    end

    def test_aria_labels_keyboard
      visit_preview(:default)
      # Details is closed by default
      assert_selector(".details-overlay summary[aria-label='Expand']", text: "Summary")

      # Open details menu
      page.evaluate_script(<<~JS)
        document.querySelector('.details-overlay summary').focus()
      JS
      keyboard.type(:enter)
      assert_selector(".details-overlay summary[aria-label='Collapse']", text: "Summary")

      # Close details menu
      keyboard.type(:enter)
      assert_selector(".details-overlay summary[aria-label='Expand']", text: "Summary")
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
  end
end
