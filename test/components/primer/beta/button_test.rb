# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaButtonTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::Beta::Button.new) { "Button" }

    assert_selector(".Button", text: "Button")
  end

  def test_renders_button_invisible_no_visuals
    render_inline(Primer::Beta::Button.new(scheme: :invisible)) { "Button" }

    assert_selector(".Button.Button--invisible-noVisuals")
  end

  def test_renders_with_leading_visual
    render_inline(Primer::Beta::Button.new) do |component|
      component.with_leading_visual_icon(icon: :alert)
      "Button"
    end

    assert_selector(".Button", text: "Button")
    assert_selector(".Button .Button-leadingVisual .octicon-alert")
  end

  def test_renders_button_with_tooltip
    render_inline(Primer::Beta::Button.new(id: "button-id")) do |component|
      component.with_tooltip(text: "Tooltip", type: :description)
      "Button"
    end

    assert_selector(".Button-withTooltip .Button", text: "Button")
    assert_selector(".Button ~ tool-tip[for='button-id']", visible: false)
  end

  def test_renders_buttons_as_a_group_item
    render_inline(Primer::Beta::Button.new(group_item: true)) { "content" }

    assert_selector(".Button.BtnGroup-item")
  end

  def test_warns_on_use_of_tooltip_without_id
    err = assert_raises ArgumentError do
      render_inline(Primer::Beta::Button.new) do |component|
        component.with_tooltip(text: "Tooltip")
        "Button"
      end
    end

    assert_equal "Buttons with a tooltip must have a unique `id` set on the `Button`.", err.message
  end

  def test_warns_on_uses_of_variant
    err = assert_raises ArgumentError do
      render_inline(Primer::Beta::Button.new(variant: :small)) { "Button" }
    end

    assert_equal "The `variant:` argument is no longer supported on Primer::Beta::Button. Consider `scheme:` or `size:`.", err.message
  end

  def test_warns_on_uses_of_dropdown
    err = assert_raises ArgumentError do
      render_inline(Primer::Beta::Button.new(dropdown: true)) { "Button" }
    end

    assert_equal "The `dropdown:` argument is no longer supported on Primer::Beta::Button. Use the `trailing_action` slot instead.", err.message
  end
end
