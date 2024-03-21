# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationTabPanelsTest < System::TestCase
    def assert_tab_panels_rendered
      assert_selector("tab-container") do
        assert_selector("button#tab-1.tabnav-tab[role='tab'][aria-selected='true']", text: "Tab 1")
        assert_selector("button#tab-2.tabnav-tab[role='tab']", text: "Tab 2")
        assert_selector("button#tab-3.tabnav-tab[role='tab']", text: "Tab 3")
        assert_selector("div#panel-tab-2[role='tabpanel']", text: "Panel 1")
        assert_selector("div#panel-tab-2[role='tabpanel']", text: "Panel 2", visible: false)
        assert_selector("div#panel-tab-3[role='tabpanel']", text: "Panel 3", visible: false)
      end
    end

    def assert_selects_tab(tab)
      click_button("Tab #{tab}")

      (1..3).each do |num|
        assert_selector("button.tabnav-tab[role='tab'][aria-selected='#{tab == num}']", text: "Tab #{num}")
      end

      assert_shows_panel(tab)
    end

    def assert_shows_panel(panel)
      (1..3).each do |num|
        assert_selector("div[role='tabpanel']#{'[hidden]' unless panel == num}", text: "Panel #{num}", visible: panel == num)
      end
    end

    def test_renders_component
      visit_preview(:default)

      assert_tab_panels_rendered
    end

    def test_changes_tabs_on_click
      visit_preview(:default)

      assert_tab_panels_rendered

      assert_selects_tab(2)
      assert_selects_tab(3)
      assert_selects_tab(1)
    end
  end
end
