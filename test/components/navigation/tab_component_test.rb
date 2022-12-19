# frozen_string_literal: true

require "components/test_helper"

class PrimerNavigationTabComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_title
    render_inline Primer::Navigation::TabComponent.new do |component|
      component.with_text { "Title" }
    end

    assert_selector("a") do
      assert_selector("span", text: "Title")
    end
    refute_selector("a[role='tab']")
  end

  def test_renders_role_only_if_with_panel
    render_inline Primer::Navigation::TabComponent.new(with_panel: true, panel_id: "panel-1") do |component|
      component.with_text { "Title" }
    end

    assert_selector("button[role='tab']") do
      assert_selector("span", text: "Title")
    end
  end

  def test_raises_if_panel_has_no_label
    err = assert_raises ArgumentError do
      render_inline Primer::Navigation::TabComponent.new(with_panel: true, panel_id: "panel-1") do |component|
        component.with_text { "Title" }
        component.with_panel { "content" }
      end
    end

    assert_equal("Panels must be labelled. Either set a unique `id` on the tab, or set an `aria-label` directly on the panel", err.message)
  end

  def test_raises_if_with_panel_and_no_panel_id
    err = assert_raises ArgumentError do
      render_inline Primer::Navigation::TabComponent.new(with_panel: true) do |component|
        # :nocov:
        component.with_text { "Title" }
        component.with_panel { "content" }
        # :nocov:
      end
    end

    assert_equal("`panel_id` is required", err.message)
  end

  def test_renders_octicon
    render_inline Primer::Navigation::TabComponent.new do |component|
      component.with_icon(icon: :star)
    end

    assert_selector(".octicon.octicon-star")
  end

  def test_renders_counter
    render_inline Primer::Navigation::TabComponent.new do |component|
      component.with_counter(count: 10)
    end

    assert_selector(".Counter", text: 10)
  end

  def test_full_component
    render_inline Primer::Navigation::TabComponent.new do |component|
      component.with_text { "Title" }
      component.with_icon(icon: :star)
      component.with_counter(count: 10)
    end

    assert_selector("span", text: "Title")
    assert_selector(".octicon.octicon-star")
    assert_selector(".Counter", text: 10)
  end

  def test_renders_custom_content
    render_inline Primer::Navigation::TabComponent.new do
      "Custom content"
    end

    assert_text("Custom content")
  end

  def test_does_not_render_custom_content_if_slots_are_used
    render_inline Primer::Navigation::TabComponent.new do |component|
      component.with_text { "Title" }
      "Custom content"
    end

    refute_text("Custom content")
  end

  def test_renders_as_button_if_has_panel
    render_inline Primer::Navigation::TabComponent.new(with_panel: true, panel_id: "panel-1") do |component|
      component.with_text { "Title" }
    end

    assert_selector("button[role='tab'][type='button'][aria-controls='panel-1']") do
      assert_selector("span", text: "Title")
    end
  end

  def test_renders_aria_current_if_link_and_selected
    render_inline Primer::Navigation::TabComponent.new(selected: true) do |component|
      component.with_text { "Title" }
    end

    assert_selector("a[aria-current='page']") do
      assert_selector("span", text: "Title")
    end
    refute_selector("a[role='tab']")
  end

  def test_renders_aria_selected_if_button_and_selected
    render_inline Primer::Navigation::TabComponent.new(selected: true, with_panel: true, panel_id: "panel-1") do |component|
      component.with_text { "Title" }
    end

    assert_selector("button[role='tab'][type='button'][aria-selected='true']") do
      assert_selector("span", text: "Title")
    end
  end

  def test_renders_icon_with_classes
    render_inline Primer::Navigation::TabComponent.new(icon_classes: "custom-class") do |component|
      component.with_icon(icon: :star)
    end

    assert_selector(".custom-class.octicon.octicon-star")
  end

  def test_renders_inside_list
    render_inline Primer::Navigation::TabComponent.new(list: true) do |component|
      component.with_text { "Title" }
    end

    assert_selector("li.d-inline-flex") do
      assert_selector("a") do
        assert_selector("span", text: "Title")
      end
    end
    refute_selector("a[role='tab']")
  end

  def test_accepts_aria_current_true
    render_inline Primer::Navigation::TabComponent.new(selected: true, "aria-current": true) do |component|
      component.with_text { "Title" }
    end

    assert_selector("a[aria-current='true']") do
      assert_selector("span", text: "Title")
    end
    refute_selector("a[role='tab']")
  end

  def test_accepts_aria_current_true_as_object
    render_inline Primer::Navigation::TabComponent.new(selected: true, aria: { current: true }) do |component|
      component.with_text { "Title" }
    end

    assert_selector("a[aria-current='true']") do
      assert_selector("span", text: "Title")
    end
    refute_selector("a[role='tab']")
  end
end
