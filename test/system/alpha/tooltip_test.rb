# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationTooltipTest < System::TestCase
    def test_renders
      visit_preview(:default)

      assert_selector("button[id='button-with-tooltip']")
      assert_selector("tool-tip[for='button-with-tooltip'][data-view-component][role='tooltip']", text: "You can press a button", visible: :hidden)
      assert_equal(find("button")["aria-describedby"], find("tool-tip", visible: :hidden)["id"])
    end

    def test_appears_and_positions_on_focus_of_button
      visit_preview(:default)

      assert_selector("tool-tip.position-absolute.sr-only", visible: :hidden)
      assert_nil(find("tool-tip", visible: :hidden)["style"]) # position not set on initial load

      find("button").send_keys("tab") # sends focus to button

      assert_selector("tool-tip.position-absolute", visible: true)
      refute_selector("tool-tip.position-absolute.sr-only", visible: true)
      style = find("tool-tip", visible: true)["style"]
      assert_equal(true, style.include?("top"))
      assert_equal(true, style.include?("left"))
    end

    def test_appears_and_positions_on_hover_of_button
      visit_preview(:default)

      assert_nil(find("tool-tip", visible: :hidden)["style"]) # position not set on initial load
      assert_selector("tool-tip.position-absolute.sr-only", visible: :hidden)

      find("button").hover

      assert_selector("tool-tip.position-absolute", visible: true)
      refute_selector("tool-tip.position-absolute.sr-only", visible: true)
      style = find("tool-tip", visible: true)["style"]
      assert_equal(true, style.include?("top"))
      assert_equal(true, style.include?("left"))
    end

    def test_hides_tooltip_on_escape
      visit_preview(:default)

      find("button").send_keys("tab") # focus
      assert_selector("tool-tip", visible: true)

      find("button").send_keys(:escape)
      assert_selector("tool-tip", visible: :hidden)
    end

    def test_appends_to_existing_aria_describedby
      visit_preview(:description_tooltip_on_button_with_existing_describedby)

      tooltip_id = find("tool-tip", visible: :hidden)["id"]
      assert_equal("existing-description-id #{tooltip_id}", find("button")["aria-describedby"])
    end

    def test_does_not_render_duplicate_describedby_id_when_attribute_callback_triggered
      visit_preview(:description_tooltip_on_button_with_existing_describedby)

      tooltip_id = find("tool-tip", visible: :hidden)["id"]
      assert_equal("existing-description-id #{tooltip_id}", find("button")["aria-describedby"])
      evaluate_script("(function(el) {
        return (
          el.setAttribute('data-type', 'label')
        );
      })(arguments[0]);", find("tool-tip", visible: :hidden))
      evaluate_script("(function(el) {
        return (
          el.setAttribute('data-type', 'description')
        );
      })(arguments[0]);", find("tool-tip", visible: :hidden))
      assert_equal("existing-description-id #{tooltip_id}", find("button")["aria-describedby"])
    end

    def test_never_aria_hidden_when_tooltip_is_description
      visit_preview(:default)

      assert_selector("tool-tip.sr-only", visible: :hidden)
      refute_selector("tool-tip.sr-only[aria-hidden]", visible: :hidden)

      find("button").send_keys("tab") # focus

      refute_selector("tool-tip.sr-only", visible: :hidden)
      assert_selector("tool-tip", visible: :visible)
      refute_selector("tool-tip[aria-hidden]", visible: :visible)
    end

    def test_does_not_overflow_and_affect_layout
      visit_preview(:with_right_most_position)
      tooltip_in_viewport = evaluate_script("(function(el) {
        return (
          el.getBoundingClientRect().right <= (window.innerWidth || document.documentElement.clientWidth) + 1
        );
      })(arguments[0]);", find("tool-tip", visible: :hidden))

      assert_equal(true, tooltip_in_viewport)
    end

    def test_only_one_visible_at_a_time
      visit_preview(:with_multiple_on_a_page)

      assert_selector("tool-tip.sr-only[for='button-1']", visible: :hidden)
      assert_selector("tool-tip.sr-only[for='button-2']", visible: :hidden)
      assert_selector("tool-tip.sr-only[for='button-3']", visible: :hidden)

      find("button#button-1").send_keys("tab") # focus

      assert_selector("tool-tip[for='button-1']", visible: :visible)
      assert_selector("tool-tip.sr-only[for='button-2']", visible: :hidden)
      assert_selector("tool-tip.sr-only[for='button-3']", visible: :hidden)

      find("button#button-2").hover

      assert_selector("tool-tip.sr-only[for='button-1']", visible: :hidden)
      assert_selector("tool-tip[for='button-2']", visible: :visible)
      assert_selector("tool-tip.sr-only[for='button-3']", visible: :hidden)
    end
  end
end
