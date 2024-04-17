# frozen_string_literal: true

require "components/test_helper"

class PrimerUnderlinePanelsTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_panels_and_tab_container
    render_inline(Primer::Alpha::UnderlinePanels.new(label: "label")) do |component|
      component.with_tab(selected: true, id: "tab-1") do |tab|
        tab.with_panel { "Panel 1" }
        tab.with_text { "Tab 1" }
      end
      component.with_tab(id: "tab-2") do |tab|
        tab.with_panel { "Panel 2" }
        tab.with_text { "Tab 2" }
      end
      component.with_actions do
        "Actions content"
      end
    end

    assert_selector("tab-container.UnderlineNav") do
      assert_selector("button.UnderlineNav-item[role='tab'][aria-selected='true']", text: "Tab 1")
      assert_selector("button.UnderlineNav-item[role='tab']", text: "Tab 2")
      assert_selector("div.UnderlineNav-actions", text: "Actions content")
    end
    assert_selector("div[role='tabpanel']", text: "Panel 1")
    assert_selector("div[role='tabpanel']", text: "Panel 2", visible: false)
  end

  def test_customizes_tab_container
    render_inline(Primer::Alpha::UnderlinePanels.new(label: "label", with_panel: true, wrapper_arguments: { m: 2, classes: "custom-class" })) do |component|
      component.with_tab(selected: true, id: "tab-1") do |tab|
        tab.with_panel { "Panel 1" }
        tab.with_text { "Tab 1" }
      end
    end

    assert_selector("div.m-2.custom-class")
  end

  def test_raises_if_multiple_tabs_are_selected
    err = assert_raises Primer::TabbedComponentHelper::MultipleSelectedTabsError do
      render_inline(Primer::Alpha::UnderlinePanels.new(label: "label")) do |component|
        component.with_tab(selected: true, id: "tab-1") do |tab|
          tab.with_panel { "Panel 1" }
          tab.with_text { "Tab 1" }
        end
        component.with_tab(id: "tab-2") do |tab|
          tab.with_panel { "Panel 2" }
          tab.with_text { "Tab 2" }
        end
        component.with_tab(selected: true, id: "tab-3") do
          tab.with_panel { "Panel 3" }
          tab.with_text { "Tab 3" }
        end
      end
    end

    assert_equal("only one tab can be selected", err.message)
  end

  def test_actions_tag_falls_back_to_default
    without_fetch_or_fallback_raises do
      render_inline(Primer::Alpha::UnderlinePanels.new(label: "label")) do |component|
        component.with_tab(selected: true, id: "tab-1") do |tab|
          tab.with_text { "Tab 1" }
          tab.with_panel { "Panel 1" }
        end
        component.with_tab(id: "tab-2") do |tab|
          tab.with_text { "Tab 2" }
          tab.with_panel { "Panel 2" }
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
      render_inline(Primer::Alpha::UnderlinePanels.new(label: "label", align: :foo)) do |component|
        component.with_tab(selected: true, id: "tab-1") do |tab|
          tab.with_text { "Tab 1" }
          tab.with_panel { "Panel 2" }
        end
        component.with_tab(id: "tab-2") do |tab|
          tab.with_text { "Tab 2" }
          tab.with_panel { "Panel 2" }
        end
        component.with_actions do
          "Actions content"
        end
      end
    end

    refute_selector(".UnderlineNav--right")

    assert_selector("tab-container.UnderlineNav") do
      assert_selector("button.UnderlineNav-item[role='tab'][aria-selected='true']", text: "Tab 1")
      assert_selector("button.UnderlineNav-item[role='tab']", text: "Tab 2")
      assert_selector("div.UnderlineNav-actions", text: "Actions content")
    end
  end

  def test_adds_underline_nav_right_when_align_right_is_set
    render_inline(Primer::Alpha::UnderlinePanels.new(label: "label", align: :right)) do |component|
      component.with_tab(selected: true, id: "tab-1") do |tab|
        tab.with_text { "Tab 1" }
        tab.with_panel { "Panel 2" }
      end
      component.with_tab(id: "tab-2") do |tab|
        tab.with_text { "Tab 2" }
        tab.with_panel { "Panel 2" }
      end
      component.with_actions do
        "Actions content"
      end
    end

    assert_selector("tab-container.UnderlineNav.UnderlineNav--right") do
      assert_selector("button.UnderlineNav-item[role='tab'][aria-selected='true']", text: "Tab 1")
      assert_selector("button.UnderlineNav-item[role='tab']", text: "Tab 2")
      assert_selector("div.UnderlineNav-actions", text: "Actions content")
    end
  end

  def test_puts_actions_first_if_align_right_and_actions_exist
    render_inline(Primer::Alpha::UnderlinePanels.new(label: "label", align: :right)) do |component|
      component.with_tab(selected: true, id: "tab-1") do |tab|
        tab.with_text { "Tab 1" }
        tab.with_panel { "Panel 2" }
      end
      component.with_tab(id: "tab-2") do |tab|
        tab.with_text { "Tab 2" }
        tab.with_panel { "Panel 2" }
      end
      component.with_actions do
        "Actions content"
      end
    end
  end

  def test_renders_tab_icon_with_correct_classes
    render_inline(Primer::Alpha::UnderlinePanels.new(label: "label", align: :right)) do |component|
      component.with_tab(selected: true, id: "tab-1") do |tab|
        tab.with_text { "Tab 1" }
        tab.with_panel { "Panel 1" }
        tab.with_icon(icon: :star)
      end
    end

    assert_selector(".UnderlineNav-octicon.octicon.octicon-star")
  end
end
