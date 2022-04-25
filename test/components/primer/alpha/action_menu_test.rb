# frozen_string_literal: true

require "test_helper"

class PrimerAlphaActionMenuTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_raises_if_no_menu_id_passed_in
    err = assert_raises ArgumentError do
      render_inline Primer::Alpha::ActionMenu.new do |component|
        component.trigger { "Trigger" }
        component.item(classes: "js-do-something") { "Does something" }
      end
    end
    assert_equal("missing keyword: :menu_id", err.message)
  end

  def test_sets_default_anchor_align_and_anchor_side
    render_inline Primer::Alpha::ActionMenu.new(menu_id: "menu-1") do |component|
      component.trigger { "Trigger" }
      component.item(classes: "js-do-something") { "Does something" }
    end

    assert_selector("action-menu[data-anchor-side='outside-bottom'][data-anchor-align='start']", visible: :false)
  end

  def test_renders_with_relevant_accessibility_attributes
    render_inline Primer::Alpha::ActionMenu.new(menu_id: "menu-1") do |component|
      component.trigger { "Trigger" }
      component.item(classes: "js-do-something") { "Does something" }
    end

    assert_selector("action-menu") do
      assert_selector("button[id='menu-1-text'][aria-haspopup='true'][aria-expanded='false']", text: "Trigger")
      assert_selector("ul[id='menu-1-list'][aria-labelledby='menu-1-text'][role='menu'][hidden]", visible: false) do
        assert_selector("li[role='none']", visible: false) do
          assert_selector("span[role='menuitem']", text: "Does something", visible: false)
        end
      end
    end
  end

  def test_falls_back_to_span_if_non_allowed_tag_is_set_as_menu_item
    without_fetch_or_fallback_raises do
      render_inline Primer::Alpha::ActionMenu.new(menu_id: "bad-menu") do |component|
        component.trigger { "Trigger" }
        component.item(tag: :details) { "Does something" }
      end
    end

    assert_selector("span[role='menuitem']", visible: :false)
  end

  def test_allows_trigger_button_to_be_icon_button
    render_inline Primer::Alpha::ActionMenu.new(menu_id: "menu-3") do |component|
      component.trigger(icon: :star, "aria-label": "Menu")
      component.item { "Does something" }
    end

    assert_selector("action-menu", visible: :false) do
      assert_selector("button[id='menu-3-text'][aria-haspopup='true'][aria-expanded='false'][aria-label='Menu']", visible: :false) do
        assert_selector("svg", visible: :false)
      end
    end
  end

  def test_allows_some_tags_as_nested_menu_item
    render_inline Primer::Alpha::ActionMenu.new(menu_id: "menu-2") do |component|
      component.trigger { "Trigger" }
      component.item(tag: :button, classes: "js-do-something") { "Does something" }
      component.item(tag: :a, href: "/") { "Site" }
      component.item(tag: :"clipboard-copy", value: "Text to copy") { "Copy text" }
    end

    assert_selector("action-menu") do
      assert_selector("button[id='menu-2-text'][aria-haspopup='true'][aria-expanded='false']", text: "Trigger")
      assert_selector("ul", visible: false) do
        assert_selector("li[role='none']", visible: false) do
          assert_selector("button[role='menuitem']", text: "Does something", visible: false)
        end
        assert_selector("li[role='none']", visible: false) do
          assert_selector("a[role='menuitem'][href='/']", text: "Site", visible: false)
        end
        assert_selector("li[role='none']", visible: false) do
          assert_selector("clipboard-copy[role='menuitem']", text: "Copy text", visible: false)
        end
      end
    end
  end
end
