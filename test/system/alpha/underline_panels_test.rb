# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationUnderlinePanelsTest < System::TestCase
    def assert_underline_panels_rendered
      assert_selector("tab-container.UnderlineNav") do
        assert_selector("button.UnderlineNav-item[role='tab'][aria-selected='true']", text: "Tab 1")
        assert_selector("button.UnderlineNav-item[role='tab']", text: "Tab 2")
        assert_selector("button.UnderlineNav-item[role='tab']", text: "Tab 3")
        assert_selector("div[role='tabpanel']", text: "Panel 1")
        assert_selector("div[role='tabpanel']", text: "Panel 2", visible: false)
        assert_selector("div[role='tabpanel']", text: "Panel 3", visible: false)
      end
    end

    def assert_selects_tab(tab)
      click_button("Tab #{tab}")

      (1..3).each do |num|
        assert_selector("button.UnderlineNav-item[role='tab'][aria-selected='#{tab == num}']", text: "Tab #{num}")
      end

      assert_shows_panel(tab)
    end

    def assert_shows_panel(panel)
      (1..3).each do |num|
        assert_selector("div[role='tabpanel']", text: "Panel #{num}", visible: panel == num)
      end
    end

    def test_renders_component
      visit_preview(:default)

      assert_underline_panels_rendered
    end

    def test_changes_tabs_on_click
      visit_preview(:default)

      assert_underline_panels_rendered

      assert_selects_tab(2)
      assert_selects_tab(3)
      assert_selects_tab(1)
    end
  end
end
