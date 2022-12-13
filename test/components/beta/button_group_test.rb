# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaButtonGroupTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_without_buttons
    render_inline(Primer::Beta::ButtonGroup.new)

    refute_selector("div.BtnGroup")
  end

  def test_renders_button_items
    render_inline(Primer::Beta::ButtonGroup.new) { |component| component.with_button { "Button" } }

    assert_selector("div.BtnGroup") do
      assert_selector("button.btn.BtnGroup-item", text: "Button")
    end
  end

  def test_renders_button_with_props
    render_inline(Primer::Beta::ButtonGroup.new) do |component|
      component.with_button { "Button" }
      component.with_button(scheme: :primary) { "Primary" }
      component.with_button(scheme: :danger) { "Danger" }
      component.with_button(scheme: :outline) { "Outline" }
      component.with_button(classes: "custom-class") { "Custom class" }
    end

    assert_selector("div.BtnGroup") do
      assert_selector("button.btn.BtnGroup-item", text: "Button")
      assert_selector("button.btn.BtnGroup-item.btn-primary", text: "Primary")
      assert_selector("button.btn.BtnGroup-item.btn-danger", text: "Danger")
      assert_selector("button.btn.BtnGroup-item.btn-outline", text: "Outline")
      assert_selector("button.btn.BtnGroup-item.custom-class", text: "Custom class")
    end
  end

  def test_does_not_render_content
    render_inline(Primer::Beta::ButtonGroup.new) { "content" }

    refute_text("content")
  end

  def test_all_buttons_with_same_size
    render_inline(Primer::Beta::ButtonGroup.new(size: :small)) do |component|
      component.with_button(size: :medium) { "Medium" }
    end

    assert_selector("div.BtnGroup") do
      assert_selector("button.btn.BtnGroup-item.btn-sm", text: "Medium")
    end
  end

  def test_all_buttons_with_same_variant
    render_inline(Primer::Beta::ButtonGroup.new(variant: :small)) do |component|
      component.with_button(size: :medium) { "Medium" }
    end

    assert_selector("div.BtnGroup") do
      assert_selector("button.btn.BtnGroup-item.btn-sm", text: "Medium")
    end
  end
end
