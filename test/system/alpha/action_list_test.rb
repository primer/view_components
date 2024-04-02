# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationActionListTest < System::TestCase
    include Primer::JsTestHelpers
    include Primer::WindowTestHelpers

    def test_js_truncate_label_shows_tooltip
      visit_preview(:long_label_with_tooltip)
      window.resize(width: 200, height: 200)

      assert_selector "li.ActionListItem span.ActionListItem-label--truncate"
      assert_selector "tool-tip", text: "Really really long label that may wrap, truncate, or appear as a tooltip", visible: :hidden

      first("button").send_keys("tab") # sends focus to button
      assert_selector "tool-tip", text: "Really really long label that may wrap, truncate, or appear as a tooltip", visible: :visible
    end

    def test_js_truncate_label_no_tooltip
      visit_preview(:long_label_wrap)
      window.resize(width: 200, height: 200)

      assert_selector "li.ActionListItem span.ActionListItem-label"
      refute_selector "tool-tip"

      find("button").send_keys("tab") # sends focus to button
      refute_selector "tool-tip"
    end

    def test_js_truncate_label_wraps
      visit_preview(:long_label_truncate_no_tooltip)
      window.resize(width: 200, height: 200)

      assert_selector "li.ActionListItem span.ActionListItem-label--truncate"
      refute_selector "tool-tip"

      find("button").send_keys("tab") # sends focus to button
      refute_selector "tool-tip"
    end
  end
end
