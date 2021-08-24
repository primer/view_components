# frozen_string_literal: true

require "test_helper"

class PrimerUnderlineNavComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_raises_if_multiple_tabs_are_selected
    err = assert_raises Primer::TabbedComponentHelper::MultipleSelectedTabsError do
      render_inline(Primer::UnderlineNavComponent.new(label: "label")) do |c|
        c.tab(selected: true) { "Tab 1" }
        c.tab { "Tab 2" }
        c.tab(selected: true) { "Tab 3" }
      end
    end

    assert_equal("only one tab can be selected", err.message)
  end

  def test_does_not_add_tab_roles_and_does_not_render_panels_if_with_panel_is_false
    render_inline(Primer::UnderlineNavComponent.new(label: "label")) do |component|
      component.tab(selected: true, href: "#", id: "tab-1") do |t|
        t.panel { "Panel 1" }
        t.text { "Tab 1" }
      end
      component.tab(href: "#", id: "tab-2") do |t|
        t.panel { "Panel 2" }
        t.text { "Tab 2" }
      end
      component.actions do
        "Actions content"
      end
    end

    assert_selector("nav.UnderlineNav[aria-label='label']") do
      assert_selector("div.UnderlineNav-body") do
        assert_selector("a.UnderlineNav-item[href='#'][aria-current='page']", text: "Tab 1")
        assert_selector("a.UnderlineNav-item[href='#']", text: "Tab 2")
      end
      assert_selector("div.UnderlineNav-actions", text: "Actions content")
    end
    refute_selector("div[role='tablist']")
    refute_selector("a[role='tab']")
  end

  def test_actions_tag_falls_back_to_default
    without_fetch_or_fallback_raises do
      render_inline(Primer::UnderlineNavComponent.new(label: "label")) do |component|
        component.tab(selected: true, href: "#") do |t|
          t.text { "Tab 1" }
        end
        component.tab(href: "#") do |t|
          t.text { "Tab 2" }
        end
        component.actions(tag: :h2) do
          "Actions content"
        end
      end
    end

    assert_selector("div.UnderlineNav-actions")
    refute_selector("h2.UnderlineNav-actions")
  end

  def test_align_falls_back_to_default
    without_fetch_or_fallback_raises do
      render_inline(Primer::UnderlineNavComponent.new(label: "label", align: :foo)) do |component|
        component.tab(selected: true, href: "#") do |t|
          t.text { "Tab 1" }
        end
        component.tab(href: "#") do |t|
          t.text { "Tab 2" }
        end
        component.actions do
          "Actions content"
        end
      end
    end

    refute_selector(".UnderlineNav--right")
    refute_selector("div[role='tabpanel']")
    refute_selector("tab-container")

    assert_selector("nav.UnderlineNav[aria-label='label']") do
      assert_selector("div.UnderlineNav-body") do
        assert_selector("a.UnderlineNav-item[href='#'][aria-current='page']", text: "Tab 1")
        assert_selector("a.UnderlineNav-item[href='#']", text: "Tab 2")
      end
      assert_selector("div.UnderlineNav-actions", text: "Actions content")
    end
  end

  def test_adds_underline_nav_right_when_align_right_is_set
    render_inline(Primer::UnderlineNavComponent.new(label: "label", align: :right)) do |component|
      component.tab(selected: true, href: "#") do |t|
        t.text { "Tab 1" }
      end
      component.tab(href: "#") do |t|
        t.text { "Tab 2" }
      end
      component.actions do
        "Actions content"
      end
    end

    refute_selector("div[role='tabpanel']")
    refute_selector("tab-container")
    assert_selector("nav.UnderlineNav.UnderlineNav--right[aria-label='label']") do
      assert_selector("div.UnderlineNav-body") do
        assert_selector("a.UnderlineNav-item[href='#'][aria-current='page']", text: "Tab 1")
        assert_selector("a.UnderlineNav-item[href='#']", text: "Tab 2")
      end
      assert_selector("div.UnderlineNav-actions", text: "Actions content")
    end
  end

  def test_puts_actions_first_if_align_right_and_actions_exist
    render_inline(Primer::UnderlineNavComponent.new(label: "label", align: :right)) do |component|
      component.tab(selected: true, href: "#") do |t|
        t.text { "Tab 1" }
      end
      component.tab(href: "#") do |t|
        t.text { "Tab 2" }
      end
      component.actions do
        "Actions content"
      end
    end

    assert_selector(".UnderlineNav > .UnderlineNav-body:last-child")
  end

  def test_renders_panels_and_tab_container
    render_inline(Primer::UnderlineNavComponent.new(label: "label", with_panel: true)) do |component|
      component.tab(selected: true, id: "tab-1", panel_id: "panel-1") do |t|
        t.panel { "Panel 1" }
        t.text { "Tab 1" }
      end
      component.tab(id: "tab-2", panel_id: "panel-2") do |t|
        t.panel { "Panel 2" }
        t.text { "Tab 2" }
      end
      component.actions do
        "Actions content"
      end
    end

    assert_selector("tab-container") do
      assert_selector("div.UnderlineNav") do
        assert_selector("div.UnderlineNav-body[role='tablist'][aria-label='label']") do
          assert_selector("button.UnderlineNav-item[role='tab'][aria-selected='true'][aria-controls='panel-1']", text: "Tab 1")
          assert_selector("button.UnderlineNav-item[role='tab'][aria-controls='panel-2']", text: "Tab 2")
        end
        assert_selector("div.UnderlineNav-actions", text: "Actions content")
      end
      assert_selector("div[id='panel-1'][role='tabpanel']", text: "Panel 1")
      assert_selector("div[id='panel-2'][role='tabpanel']", text: "Panel 2", visible: false)
    end
  end

  def test_renders_tab_icon_with_correct_classes
    render_inline(Primer::UnderlineNavComponent.new(label: "label", align: :right)) do |component|
      component.tab(selected: true, href: "#", id: "tab-1") do |t|
        t.panel { "Panel 1" }
        t.text { "Tab 1" }
        t.icon(icon: :star)
      end
    end

    assert_selector(".UnderlineNav-octicon.octicon.octicon-star")
  end

  def test_renders_navigation_links_in_a_list
    render_inline(Primer::UnderlineNavComponent.new(label: "label", body_arguments: { tag: :ul })) do |component|
      component.tab(selected: true, href: "#") do |t|
        t.text { "Tab 1" }
      end
      component.tab(href: "#") do |t|
        t.text { "Tab 2" }
      end
      component.actions do
        "Actions content"
      end
    end

    assert_selector("nav.UnderlineNav[aria-label='label']") do
      assert_selector("ul.UnderlineNav-body.list-style-none") do
        assert_selector("li") do
          assert_selector("a.UnderlineNav-item[href='#'][aria-current='page']", text: "Tab 1")
        end
        assert_selector("li") do
          assert_selector("a.UnderlineNav-item[href='#']", text: "Tab 2")
        end
      end
      assert_selector("div.UnderlineNav-actions", text: "Actions content")
    end
    refute_selector("div[role='tablist']")
    refute_selector("a[role='tab']")
  end

  def test_customizes_tab_container
    render_inline(Primer::UnderlineNavComponent.new(label: "label", with_panel: true, wrapper_arguments: { m: 2, classes: "custom-class" })) do |component|
      component.tab(selected: true, id: "tab-1", panel_id: "panel-1") do |t|
        t.panel { "Panel 1" }
        t.text { "Tab 1" }
      end
    end

    assert_selector("tab-container.m-2.custom-class")
  end
end
