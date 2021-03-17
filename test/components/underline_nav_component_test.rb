# frozen_string_literal: true

require "test_helper"

class PrimerUnderlineNavComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_raises_if_no_tab_is_rendered
    err = assert_raises Primer::TabbedComponentHelper::NoSelectedTabsError do
      render_inline(Primer::UnderlineNavComponent.new) do |component|
        component.actions do
          "Actions content"
        end
      end
    end

    assert_equal("a tab must be selected", err.message)
  end

  def test_raises_if_no_tab_is_selected
    err = assert_raises Primer::TabbedComponentHelper::NoSelectedTabsError do
      render_inline(Primer::UnderlineNavComponent.new) do |c|
        c.tab { "Tab 1" }
        c.tab { "Tab 2" }
        c.tab { "Tab 3" }
      end
    end

    assert_equal("a tab must be selected", err.message)
  end

  def test_raises_if_multiple_tabs_are_selected
    err = assert_raises Primer::TabbedComponentHelper::MultipleSelectedTabsError do
      render_inline(Primer::UnderlineNavComponent.new) do |c|
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

  def test_align_falls_back_to_default
    without_fetch_or_fallback_raises do
      render_inline(Primer::UnderlineNavComponent.new(align: :foo)) do |component|
        component.tab(selected: true, href: "#") do |t|
          t.panel { "Panel 1" }
          "Tab 1"
        end
        component.tab(href: "#") do |t|
          t.panel { "Panel 2" }
          "Tab 2"
        end
        component.actions do
          "Actions content"
        end
      end
    end

    refute_selector(".UnderlineNav--right")
    refute_selector("div[role='tabpanel']")
    refute_selector("tab-container")

    assert_selector("nav.UnderlineNav[role='tablist']") do
      assert_selector("div.UnderlineNav-body") do
        assert_selector("a.UnderlineNav-item[role='tab'][href='#'][aria-current='page']", text: "Tab 1")
        assert_selector("a.UnderlineNav-item[role='tab'][href='#']", text: "Tab 2")
      end
      assert_selector("div.UnderlineNav-actions", text: "Actions content")
    end
  end

  def test_adds_underline_nav_right_when_align_right_is_set
    render_inline(Primer::UnderlineNavComponent.new(align: :right)) do |component|
      component.tab(selected: true, href: "#") do |t|
        t.panel { "Panel 1" }
        "Tab 1"
      end
      component.tab(href: "#") do |t|
        t.panel { "Panel 2" }
        "Tab 2"
      end
      component.actions do
        "Actions content"
      end
    end

    refute_selector("div[role='tabpanel']")
    refute_selector("tab-container")
    assert_selector("nav.UnderlineNav.UnderlineNav--right[role='tablist']") do
      assert_selector("div.UnderlineNav-body") do
        assert_selector("a.UnderlineNav-item[role='tab'][href='#'][aria-current='page']", text: "Tab 1")
        assert_selector("a.UnderlineNav-item[role='tab'][href='#']", text: "Tab 2")
      end
      assert_selector("div.UnderlineNav-actions", text: "Actions content")
    end
  end

  def test_puts_actions_first_if_align_right_and_actions_exist
    render_inline(Primer::UnderlineNavComponent.new(align: :right)) do |component|
      component.tab(selected: true, href: "#") do |t|
        t.panel { "Panel 1" }
        "Tab 1"
      end
      component.tab(href: "#") do |t|
        t.panel { "Panel 2" }
        "Tab 2"
      end
      component.actions do
        "Actions content"
      end
    end

    assert_selector(".UnderlineNav > .UnderlineNav-body:last-child")
  end

  def test_renders_panels_and_tab_container
    render_inline(Primer::UnderlineNavComponent.new(with_panel: true)) do |component|
      component.tab(selected: true) do |t|
        t.panel { "Panel 1" }
        "Tab 1"
      end
      component.tab do |t|
        t.panel { "Panel 2" }
        "Tab 2"
      end
      component.actions do
        "Actions content"
      end
    end

    assert_selector("tab-container") do
      assert_selector("nav.UnderlineNav[role='tablist']") do
        assert_selector("div.UnderlineNav-body") do
          assert_selector("button.UnderlineNav-item[role='tab'][aria-selected='true']", text: "Tab 1")
          assert_selector("button.UnderlineNav-item[role='tab']", text: "Tab 2")
        end
        assert_selector("div.UnderlineNav-actions", text: "Actions content")
      end
      assert_selector("div[role='tabpanel']", text: "Panel 1")
      assert_selector("div[role='tabpanel']", text: "Panel 2", visible: false)
    end
  end
end
