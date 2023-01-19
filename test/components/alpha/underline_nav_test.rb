# frozen_string_literal: true

require "components/test_helper"

class PrimerUnderlineNavTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_raises_if_multiple_tabs_are_selected
    err = assert_raises Primer::TabbedComponentHelper::MultipleSelectedTabsError do
      render_inline(Primer::Alpha::UnderlineNav.new(label: "label")) do |component|
        component.with_tab(selected: true) { "Tab 1" }
        component.with_tab { "Tab 2" }
        component.with_tab(selected: true) { "Tab 3" }
      end
    end

    assert_equal("only one tab can be selected", err.message)
  end

  def test_actions_tag_falls_back_to_default
    without_fetch_or_fallback_raises do
      render_inline(Primer::Alpha::UnderlineNav.new(label: "label")) do |component|
        component.with_tab(selected: true, href: "#") do |tab|
          tab.with_text { "Tab 1" }
        end
        component.with_tab(href: "#") do |tab|
          tab.with_text { "Tab 2" }
        end
        component.with_actions(tag: :h2) do
          "Actions content"
        end
      end
    end

    assert_selector("div.UnderlineNav-actions")
    refute_selector("h2.UnderlineNav-actions")
  end

  def test_align_falls_back_to_default
    without_fetch_or_fallback_raises do
      render_inline(Primer::Alpha::UnderlineNav.new(label: "label", align: :foo)) do |component|
        component.with_tab(selected: true, href: "#") do |tab|
          tab.with_text { "Tab 1" }
        end
        component.with_tab(href: "#") do |tab|
          tab.with_text { "Tab 2" }
        end
        component.with_actions do
          "Actions content"
        end
      end
    end

    refute_selector(".UnderlineNav--right")
    refute_selector("tab-container")

    assert_selector("nav.UnderlineNav[aria-label='label']") do
      assert_selector("ul.UnderlineNav-body") do
        assert_selector("li") do
          assert_selector("a.UnderlineNav-item[href='#'][aria-current='page']", text: "Tab 1")
        end
        assert_selector("li") do
          assert_selector("a.UnderlineNav-item[href='#']", text: "Tab 2")
        end
      end
      assert_selector("div.UnderlineNav-actions", text: "Actions content")
    end
  end

  def test_adds_underline_nav_right_when_align_right_is_set
    render_inline(Primer::Alpha::UnderlineNav.new(label: "label", align: :right)) do |component|
      component.with_tab(selected: true, href: "#") do |tab|
        tab.with_text { "Tab 1" }
      end
      component.with_tab(href: "#") do |tab|
        tab.with_text { "Tab 2" }
      end
      component.with_actions do
        "Actions content"
      end
    end

    assert_selector("nav.UnderlineNav.UnderlineNav--right[aria-label='label']") do
      assert_selector("ul.UnderlineNav-body") do
        assert_selector("li") do
          assert_selector("a.UnderlineNav-item[href='#'][aria-current='page']", text: "Tab 1")
        end
        assert_selector("li") do
          assert_selector("a.UnderlineNav-item[href='#']", text: "Tab 2")
        end
      end
      assert_selector("div.UnderlineNav-actions", text: "Actions content")
    end
  end

  def test_puts_actions_first_if_align_right_and_actions_exist
    render_inline(Primer::Alpha::UnderlineNav.new(label: "label", align: :right)) do |component|
      component.with_tab(selected: true, href: "#") do |tab|
        tab.with_text { "Tab 1" }
      end
      component.with_tab(href: "#") do |tab|
        tab.with_text { "Tab 2" }
      end
      component.with_actions do
        "Actions content"
      end
    end

    assert_selector(".UnderlineNav > .UnderlineNav-body:last-child")
  end

  def test_renders_tab_icon_with_correct_classes
    render_inline(Primer::Alpha::UnderlineNav.new(label: "label", align: :right)) do |component|
      component.with_tab(selected: true, href: "#", id: "tab-1") do |tab|
        tab.with_text { "Tab 1" }
        tab.with_icon(icon: :star)
      end
    end

    assert_selector(".UnderlineNav-octicon.octicon.octicon-star")
  end
end
