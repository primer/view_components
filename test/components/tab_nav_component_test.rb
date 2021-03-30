# frozen_string_literal: true

require "test_helper"

class PrimerTabNavComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_raises_if_multiple_tabs_are_selected
    err = assert_raises Primer::TabbedComponentHelper::MultipleSelectedTabsError do
      render_inline(Primer::TabNavComponent.new) do |c|
        c.tab(selected: true) do
          "Tab 1"
        end
        c.tab { "Tab 2" }
        c.tab(selected: true) do
          "Tab 3"
        end
      end
    end

    assert_equal("only one tab can be selected", err.message)
  end

  def test_renders_tabs
    render_inline(Primer::TabNavComponent.new) do |c|
      c.tab(selected: true) { "Tab 1" }
      c.tab { "Tab 2" }
    end

    assert_selector(".tabnav") do
      assert_selector("nav.tabnav-tabs") do
        assert_selector("a.tabnav-tab[aria-current='page']", text: "Tab 1")
        assert_selector("a.tabnav-tab", text: "Tab 2")
      end
    end
  end

  def test_renders_tabs_as_buttons
    render_inline(Primer::TabNavComponent.new) do |c|
      c.tab(tag: :button, selected: true) { "Tab 1" }
      c.tab(tag: :button) { "Tab 2" }
    end

    assert_selector(".tabnav") do
      assert_selector("nav.tabnav-tabs") do
        assert_selector("button.tabnav-tab[aria-selected='true']", text: "Tab 1")
        assert_selector("button.tabnav-tab", text: "Tab 2")
      end
    end
  end

  def test_renders_tab_panels_with_tabs_as_button
    render_inline(Primer::TabNavComponent.new(with_panel: true)) do |c|
      c.tab(selected: true) do |t|
        t.panel { "Panel 1" }
        t.text { "Tab 1" }
      end
      c.tab do |t|
        t.panel { "Panel 2" }
        t.text { "Tab 2" }
      end
    end

    assert_selector(".tabnav") do
      assert_selector("nav.tabnav-tabs[role='tablist']") do
        assert_selector("button.tabnav-tab[aria-selected='true'][role='tab']", text: "Tab 1")
        assert_selector("button.tabnav-tab[role='tab']", text: "Tab 2")
      end
    end
    assert_selector("div[role='tabpanel']", text: "Panel 1")
    assert_selector("div[role='tabpanel'][hidden]", text: "Panel 2", visible: false)
  end

  def test_only_renders_panels_for_tabs_with_content
    render_inline(Primer::TabNavComponent.new(with_panel: true)) do |c|
      c.tab(tag: :button, selected: true) do |t|
        t.panel { "Panel 1" }
        t.text { "Tab 1" }
      end
      c.tab(tag: :button) { "Tab 2" }
    end

    assert_selector(".tabnav") do
      assert_selector("nav.tabnav-tabs[role='tablist']") do
        assert_selector("button.tabnav-tab[aria-selected='true'][role='tab']", text: "Tab 1")
        assert_selector("button.tabnav-tab[role='tab']", text: "Tab 2")
      end
    end
    assert_selector("div[role='tabpanel']", count: 1)
  end

  def test_does_not_render_panels_when_with_panel_is_false
    render_inline(Primer::TabNavComponent.new(with_panel: false)) do |c|
      c.tab(selected: true) do |t|
        t.panel { "Panel 1" }
        t.text { "Tab 1" }
      end
      c.tab do |t|
        t.panel { "Panel 2" }
        t.text { "Tab 2" }
      end
    end

    assert_selector(".tabnav") do
      assert_selector("nav.tabnav-tabs") do
        assert_selector("a.tabnav-tab[aria-current='page']", text: "Tab 1")
        assert_selector("a.tabnav-tab", text: "Tab 2")
      end
    end
    refute_selector("div[role='tabpanel']")
  end
end
