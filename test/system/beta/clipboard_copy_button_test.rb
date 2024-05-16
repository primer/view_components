# frozen_string_literal: true

require "system/test_case"

module Beta
  class IntegrationClipboardCopyButtonTest < System::TestCase
    include Primer::ClipboardTestHelpers

    def test_copies_text
      visit_preview(:playground)

      clipboard_text = capture_clipboard do
        find("#clipboard-button").click
      end

      assert_equal "Text to copy", clipboard_text
      assert_selector("[data-clipboard-copy-feedback]", text: "Copied!", visible: :false)
    end

    def test_includes_tooltip
      visit_preview(:with_tooltip)

      assert_selector "tool-tip[for='clipboard-button']", visible: :all
    end
  end
end
