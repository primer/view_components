# frozen_string_literal: true

require "test_helper"

class PrimerButtonGroupComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_group
    render_inline(Primer::ButtonGroupComponent.new)

    assert_selector("div.BtnGroup")
  end

  def test_renders_button_items
    render_inline(Primer::ButtonGroupComponent.new) { |c| c.button { "Button" } }

    assert_selector("div.BtnGroup") do
      assert_selector("button.btn.BtnGroup-item", text: "Button")
    end
  end

  def test_renders_button_with_props
    render_inline(Primer::ButtonGroupComponent.new) do |c|
      c.button { "Button" }
      c.button(button_type: :primary) { "Primary" }
      c.button(button_type: :danger) { "Danger" }
      c.button(button_type: :outline) { "Outline" }
      c.button(classes: "my-class") { "Custom class" }
    end

    assert_selector("div.BtnGroup") do
      assert_selector("button.btn.BtnGroup-item", text: "Button")
      assert_selector("button.btn.BtnGroup-item.btn-primary", text: "Primary")
      assert_selector("button.btn.BtnGroup-item.btn-danger", text: "Danger")
      assert_selector("button.btn.BtnGroup-item.btn-outline", text: "Outline")
      assert_selector("button.btn.BtnGroup-item.my-class", text: "Custom class")
    end
  end

  def test_does_not_render_content
    render_inline(Primer::ButtonGroupComponent.new) { "content" }

    refute_text("content")
  end
end
