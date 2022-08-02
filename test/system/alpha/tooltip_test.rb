# frozen_string_literal: true

require "application_system_test_case"

module Alpha
  class IntegrationTooltipTest < ApplicationSystemTestCase
    def test_renders
      visit_preview(:default)

      assert_selector("button[id='button-with-tooltip']")
      assert_selector("tool-tip[for='button-with-tooltip'][data-view-component][role='tooltip']", visible: false, text: "Tooltip text")
      assert_equal(find("button")["aria-describedby"], find("tool-tip", visible: false)["id"])
    end
  end
end
