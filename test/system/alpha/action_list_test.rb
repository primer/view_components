# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationActionListTest < System::TestCase
    include Primer::JsTestHelpers

    def test_js_truncate_label
      visit_preview(:long_label)
      assert_selector "li.ActionListItem", text: "Really really long label that may wrap, truncate, or appear as a tooltip"
      assert_selector "li.ActionListItem span.ActionListItem-label--truncate"
      assert_selector "tool-tip[data-view-component][role='tooltip']", text: "Really really long label that may wrap, truncate, or appear as a tooltip", visible: :hidden

      find("button").send_keys("tab") # sends focus to button
      assert_selector "tool-tip[data-view-component][role='tooltip']", text: "Really really long label that may wrap, truncate, or appear as a tooltip", visible: :hidden
    end
  end
end
