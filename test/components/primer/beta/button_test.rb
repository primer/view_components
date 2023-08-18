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

  def test_renders_with_leading_visual_icon
    render_inline(Primer::Beta::Button.new) do |component|
      component.with_leading_visual_icon(icon: :alert)
      "Button"
    end

    assert_selector(".Button", text: "Button")
    assert_selector(".Button .Button-leadingVisual .octicon-alert")
  end

  def test_renders_with_leading_visual_svg
    render_inline(Primer::Beta::Button.new) do |component|
      component.with_leading_visual_svg do
        '<path d="M8 16a2 2 0 001.985-1.75c.017-.137-.097-.25-.235-.25h-3.5c-.138 0-.252.113-.235.25A2 2 0 008 16z"></path><path fill-rule="evenodd" d="M8 1.5A3.5 3.5 0 004.5 5v2.947c0 .346-.102.683-.294.97l-1.703 2.556a.018.018 0 00-.003.01l.001.006c0 .002.002.004.004.006a.017.017 0 00.006.004l.007.001h10.964l.007-.001a.016.016 0 00.006-.004.016.016 0 00.004-.006l.001-.007a.017.017 0 00-.003-.01l-1.703-2.554a1.75 1.75 0 01-.294-.97V5A3.5 3.5 0 008 1.5zM3 5a5 5 0 0110 0v2.947c0 .05.015.098.042.139l1.703 2.555A1.518 1.518 0 0113.482 13H2.518a1.518 1.518 0 01-1.263-2.36l1.703-2.554A.25.25 0 003 7.947V5z"></path>'.html_safe
      end
      "Button"
    end

    assert_selector(".Button", text: "Button")
    assert_selector(".Button .Button-leadingVisual")
  end

  def test_renders_button_with_tooltip
    render_inline(Primer::Beta::Button.new(id: "button-id")) do |component|
      component.with_tooltip(text: "Tooltip", type: :description)
      "Button"
    end

    assert_selector(".Button-withTooltip .Button", text: "Button")
    assert_selector(".Button ~ tool-tip[for='button-id']", visible: false)
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
