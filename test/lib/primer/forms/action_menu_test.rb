# frozen_string_literal: true
require "system/test_case"

module Forms
  class ActionMenuTest < System::TestCase

    def test_label_aria_describes_button
      visit_preview(:action_menu_form)
      assert_equal(find("label")["id"], find("button", text: "Select...")["aria-describedby"])
    end
  end
end