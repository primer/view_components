# frozen_string_literal: true

require "application_system_test_case"

module Alpha
  class IntegrationTooltipTest < ApplicationSystemTestCase
    def test_renders
      visit_preview(:default)

      assert_selector("button[id='button-with-tooltip']")
      assert_selector("tool-tip[for='button-with-tooltip'][data-view-component][role='tooltip']", visible: false, text: "Tooltip text")
      assert_equal(find("button")["aria-describedby"], find("tool-tip", visible: false)["id"])
      assert_equal("position-absolute", find("tool-tip", visible: false)["class"])
    end

    def test_retains_existing_aria_labelledby
      visit_preview(:label_tooltip_on_button_with_existing_labelledby)

      tooltip_id = find("tool-tip", visible: false)["id"]
      assert_equal("existing-label-id #{tooltip_id}", find("button")["aria-labelledby"])
    end

    def test_retains_existing_aria_describedby
      visit_preview(:description_tooltip_on_button_with_existing_describedby)

      tooltip_id = find("tool-tip", visible: false)["id"]
      assert_equal("existing-description-id #{tooltip_id}", find("button")["aria-describedby"])
    end
  end
end
