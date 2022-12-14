# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaTabNavTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_raises_if_multiple_tabs_are_selected
    err = assert_raises Primer::TabbedComponentHelper::MultipleSelectedTabsError do
      render_inline(Primer::Alpha::TabNav.new(label: "label")) do |component|
        component.with_tab(selected: true) { "Tab 1" }
        component.with_tab { "Tab 2" }
        component.with_tab(selected: true) { "Tab 3" }
      end
    end

    assert_equal("only one tab can be selected", err.message)
  end

  def test_renders_tabs
    render_inline(Primer::Alpha::TabNav.new(label: "label")) do |component|
      component.with_tab(selected: true) { "Tab 1" }
      component.with_tab { "Tab 2" }
    end

    refute_selector("tab-container")
    assert_selector("nav.tabnav[aria-label='label']") do
      assert_selector("ul.tabnav-tabs") do
        assert_selector("li") do
          assert_selector("a.tabnav-tab[aria-current='page']", text: "Tab 1")
        end
        assert_selector("li") do
          assert_selector("a.tabnav-tab", text: "Tab 2")
        end
      end
    end
  end

  def test_renders_tag_as_div_and_aria_label_on_list
    render_inline(Primer::Alpha::TabNav.new(label: "label", tag: :div)) do |component|
      component.with_tab(selected: true) { "Tab 1" }
      component.with_tab { "Tab 2" }
    end

    assert_selector("div.tabnav") do
      assert_selector("ul.tabnav-tabs[aria-label='label']") do
        assert_selector("li") do
          assert_selector("a.tabnav-tab[aria-current='page']", text: "Tab 1")
        end
        assert_selector("li") do
          assert_selector("a.tabnav-tab", text: "Tab 2")
        end
      end
    end
  end

  def test_renders_extra_content
    render_inline(Primer::Alpha::TabNav.new(label: "label")) do |component|
      component.with_tab(selected: true) { "Tab 1" }
      component.with_tab { "Tab 2" }
      component.with_extra { "Extra" }
    end

    assert_selector(".tabnav") do
      assert_selector("nav.tabnav[aria-label='label']") do
        assert_selector("ul.tabnav-tabs") do
          assert_selector("li") do
            assert_selector("a.tabnav-tab[aria-current='page']", text: "Tab 1")
          end
          assert_selector("li") do
            assert_selector("a.tabnav-tab", text: "Tab 2")
          end
        end
      end
      assert_text("Extra")
    end
  end

  def test_renders_extra_content_after_the_tabs
    render_inline(Primer::Alpha::TabNav.new(label: "label")) do |component|
      component.with_tab(selected: true) { "Tab 1" }
      component.with_tab { "Tab 2" }
      component.with_extra(align: :right) { "Extra" }
    end

    assert_selector("nav.tabnav[aria-label='label']") do
      assert_selector("ul.tabnav-tabs") do
        assert_selector("li") do
          assert_selector("a.tabnav-tab[aria-current='page']", text: "Tab 1")
        end
        assert_selector("li") do
          assert_selector("a.tabnav-tab", text: "Tab 2")
        end
      end
      assert_text("Extra")
    end
  end

  def test_renders_custom_body_class
    render_inline(Primer::Alpha::TabNav.new(label: "label", body_arguments: { classes: "custom-body-class" }))

    assert_selector("nav.tabnav[aria-label='label']") do
      assert_selector("ul.tabnav-tabs.custom-body-class")
      refute_selector("ul.tabnav-tabs.tabnav")
    end
  end
end
