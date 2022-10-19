# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaTabPanelsTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_raises_if_multiple_tabs_are_selected
    err = assert_raises Primer::TabbedComponentHelper::MultipleSelectedTabsError do
      render_inline(Primer::Alpha::TabPanels.new(label: "label")) do |c|
        c.tab(id: "tab-1", selected: true)
        c.tab(id: "tab-2")
        c.tab(id: "tab-3", selected: true)
      end
    end

    assert_equal("only one tab can be selected", err.message)
  end

  def test_renders_tabs_and_panels_with_relevant_aria_attributes
    render_inline(Primer::Alpha::TabPanels.new(label: "label")) do |c|
      c.tab(selected: true, id: "tab-1") do |t|
        t.panel { "Panel 1" }
        t.text { "Tab 1" }
      end
      c.tab(id: "tab-2") do |t|
        t.panel { "Panel 2" }
        t.text { "Tab 2" }
      end
      c.extra { "extra" }
    end

    assert_selector("tab-container") do
      assert_selector("div.tabnav") do
        assert_selector("ul.tabnav-tabs[aria-label='label']") do
          assert_selector("li") do
            assert_selector("button#tab-1.tabnav-tab[aria-selected='true']", text: "Tab 1")
          end
          assert_selector("li") do
            assert_selector("button#tab-2.tabnav-tab", text: "Tab 2")
          end
        end
      end
      assert_selector("div#panel-tab-1[aria-labelledby='tab-1']", text: "Panel 1")
      assert_selector("div#panel-tab-2[aria-labelledby='tab-2']", text: "Panel 2", visible: false)
    end
  end

  def test_customizes_tab_container
    render_inline(Primer::Alpha::TabPanels.new(label: "label", wrapper_arguments: { m: 2, classes: "custom-class" })) do |c|
      c.tab(selected: true, id: "tab-1") do |t|
        t.panel { "Panel 1" }
        t.text { "Tab 1" }
      end
    end

    assert_selector("tab-container.m-2.custom-class")
  end

  def test_renders_extra_content
    render_inline(Primer::Alpha::TabPanels.new(label: "label")) do |c|
      c.tab(selected: true, id: "tab-1") do |t|
        t.panel { "Panel 1" }
        t.text { "Tab 1" }
      end
      c.tab(id: "tab-2") do |t|
        t.panel { "Panel 2" }
        t.text { "Tab 2" }
      end
      c.extra { "extra" }
    end
    assert_selector("tab-container") do
      assert_selector("div.tabnav") do
        assert_selector("ul.tabnav-tabs[aria-label='label']") do
          assert_selector("li") do
            assert_selector("button#tab-1.tabnav-tab[aria-selected='true']", text: "Tab 1")
          end
          assert_selector("li") do
            assert_selector("button#tab-2.tabnav-tab", text: "Tab 2")
          end
        end
      end
      assert_selector("div#panel-tab-1[aria-labelledby='tab-1']", text: "Panel 1")
      assert_selector("div#panel-tab-2[aria-labelledby='tab-2']", text: "Panel 2", visible: false)
      assert_text("extra")
    end
  end
end
