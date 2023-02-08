# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaTabPanelsTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_raises_if_multiple_tabs_are_selected
    err = assert_raises Primer::TabbedComponentHelper::MultipleSelectedTabsError do
      render_inline(Primer::Alpha::TabPanels.new(label: "label")) do |component|
        component.with_tab(id: "tab-1", selected: true)
        component.with_tab(id: "tab-2")
        component.with_tab(id: "tab-3", selected: true)
      end
    end

    assert_equal("only one tab can be selected", err.message)
  end

  def test_renders_tabs_and_panels_with_relevant_aria_attributes
    render_inline(Primer::Alpha::TabPanels.new(label: "label")) do |component|
      component.with_tab(selected: true, id: "tab-1") do |tab|
        tab.with_panel { "Panel 1" }
        tab.with_text { "Tab 1" }
      end
      component.with_tab(id: "tab-2") do |tab|
        tab.with_panel { "Panel 2" }
        tab.with_text { "Tab 2" }
      end
      component.with_extra { "extra" }
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
    render_inline(Primer::Alpha::TabPanels.new(label: "label", wrapper_arguments: { m: 2, classes: "custom-class" })) do |component|
      component.with_tab(selected: true, id: "tab-1") do |tab|
        tab.with_panel { "Panel 1" }
        tab.with_text { "Tab 1" }
      end
    end

    assert_selector("tab-container.m-2.custom-class")
  end

  def test_renders_extra_content
    render_inline(Primer::Alpha::TabPanels.new(label: "label")) do |component|
      component.with_tab(selected: true, id: "tab-1") do |tab|
        tab.with_panel { "Panel 1" }
        tab.with_text { "Tab 1" }
      end
      component.with_tab(id: "tab-2") do |tab|
        tab.with_panel { "Panel 2" }
        tab.with_text { "Tab 2" }
      end
      component.with_extra { "extra" }
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

  def test_does_not_double_render_extra_content_in_production
    Rails.stub(:env, "production".inquiry) do
      # Since we've forced ourselves into the prod environment and there's no secret key base
      # configured for prod, we have to fake it by setting the appropriate environment variable.
      with_env("SECRET_KEY_BASE" => "abc123") do
        render_inline(Primer::Alpha::TabPanels.new(label: "label")) do |component|
          component.with_tab(selected: true, id: "tab-1") do |tab|
            tab.with_panel { "Panel 1" }
            tab.with_text { "Tab 1" }
          end
          component.with_extra(align: :right) { "extra" }
        end
      end
    end

    assert_text("extra", count: 1)
  end
end
