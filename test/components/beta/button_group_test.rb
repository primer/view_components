# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaButtonGroupTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_without_buttons
    render_inline(Primer::Beta::ButtonGroup.new)

    refute_selector("div.ButtonGroup")
  end

  def test_renders_button_items
    render_inline(Primer::Beta::ButtonGroup.new) { |component| component.with_button { "Button" } }

    assert_selector("div.ButtonGroup") do
      assert_selector("button.Button", text: "Button")
    end
  end

  def test_renders_button_with_props
    render_inline(Primer::Beta::ButtonGroup.new) do |component|
      component.with_button { "Button" }
      component.with_button(scheme: :primary) { "Primary" }
      component.with_button(scheme: :danger) { "Danger" }
      component.with_button(classes: "custom-class") { "Custom class" }
    end

    assert_selector("div.ButtonGroup") do
      assert_selector("button.Button", text: "Button")
      assert_selector("button.Button.Button--primary", text: "Primary")
      assert_selector("button.Button.Button--danger", text: "Danger")
      assert_selector("button.Button.custom-class", text: "Custom class")
    end
  end

  def test_does_not_render_content
    render_inline(Primer::Beta::ButtonGroup.new) { "content" }

    refute_text("content")
  end

  def test_all_buttons_with_same_size
    render_inline(Primer::Beta::ButtonGroup.new(size: :small)) do |component|
      component.with_button(size: :medium) { "Medium" }
      component.with_button(size: :large) { "Large" }
    end

    assert_selector("div.ButtonGroup") do
      assert_selector("button.Button.Button-small", text: "Medium")
      assert_selector("button.Button.Button-small", text: "Large")
    end
  end

  def test_all_buttons_with_same_scheme
    render_inline(Primer::Beta::ButtonGroup.new(scheme: :primary)) do |component|
      component.with_button(scheme: :primary) { "Primary" }
      component.with_button(scheme: :danger) { "Danger" }
    end

    assert_selector("div.ButtonGroup") do
      assert_selector("button.Button.Button--primary", text: "Primary")
      assert_selector("button.Button.Button--primary", text: "Danger")
    end
  end
end
