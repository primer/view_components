# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaButtonGroupTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_without_buttons
    render_inline(Primer::Beta::ButtonGroup.new)

    refute_selector("div.BtnGroup")
  end

  def test_renders_button_items
    render_inline(Primer::Beta::ButtonGroup.new) { |c| c.button { "Button" } }

    assert_selector("div.BtnGroup") do
      assert_selector("button.btn.BtnGroup-item", text: "Button")
    end
  end

  def test_renders_button_with_props
    render_inline(Primer::Beta::ButtonGroup.new) do |c|
      c.button { "Button" }
      c.button(scheme: :primary) { "Primary" }
      c.button(scheme: :danger) { "Danger" }
      c.button(scheme: :outline) { "Outline" }
      c.button(classes: "custom-class") { "Custom class" }
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
    render_inline(Primer::Beta::ButtonGroup.new(size: :small)) do |c|
      c.button(size: :medium) { "Medium" }
    end

    assert_selector("div.BtnGroup") do
      assert_selector("button.btn.BtnGroup-item.btn-sm", text: "Medium")
    end
  end

  def test_all_buttons_with_same_variant
    render_inline(Primer::Beta::ButtonGroup.new(variant: :small)) do |c|
      c.button(size: :medium) { "Medium" }
    end

    assert_selector("div.BtnGroup") do
      assert_selector("button.btn.BtnGroup-item.btn-sm", text: "Medium")
    end
  end
end
