# frozen_string_literal: true

require "system/test_case"

module Beta
  class IntegrationButtonGroupTest < System::TestCase
    include Primer::ClipboardTestHelpers

    def test_clipboard_copy_button_copies_text
      visit_preview(:with_clipboard_copy_button)

      clipboard_text = capture_clipboard do
        find("#button-2").click
      end

      assert_equal "Copyable value", clipboard_text
    end
  end
end
