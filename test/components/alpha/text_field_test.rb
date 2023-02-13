# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaTextFieldTest < MiniTest::Test
  include ViewComponent::TestHelpers

  def setup
    @default_params = {
      name: "foo", id: "foo", label: "Foo"
    }
  end

  def test_renders_a_text_input_with_the_given_name_and_id
    render_inline(Primer::Alpha::TextField.new(**@default_params))

    assert_selector "label.FormControl-label", text: "Foo"
    assert_selector "input[type=text][name=foo][id=foo]"
  end

  def test_visually_hides_the_label
    render_inline(Primer::Alpha::TextField.new(**@default_params, visually_hide_label: true))

    assert_selector "label.FormControl-label.sr-only", text: "Foo"
  end

  def test_renders_in_the_medium_size_by_default
    render_inline(Primer::Alpha::TextField.new(**@default_params))

    assert_selector("input.FormControl-medium")
  end

  def test_renders_in_the_large_size
    render_inline(Primer::Alpha::TextField.new(**@default_params, size: :large))

    assert_selector("input.FormControl-large")
  end

  def test_renders_a_clear_button
    render_inline(
      Primer::Alpha::TextField.new(
        **@default_params,
        show_clear_button: true,
        clear_button_id: "clear-button-id"
      )
    )

    assert_selector "button.FormControl-input-trailingAction#clear-button-id"
  end

  def test_renders_the_component_full_width
    render_inline(Primer::Alpha::TextField.new(**@default_params, full_width: true))

    assert_selector ".FormControl--fullWidth input"
  end

  def test_marks_the_input_as_disabled
    render_inline(Primer::Alpha::TextField.new(**@default_params, disabled: true))

    assert_selector "input[disabled]"
  end

  def test_marks_the_input_as_invalid
    render_inline(Primer::Alpha::TextField.new(**@default_params, invalid: true))

    assert_selector "input[invalid]"
  end

  def test_renders_the_component_with_an_inset_style
    render_inline(Primer::Alpha::TextField.new(**@default_params, inset: true))

    assert_selector "input.FormControl-inset"
  end

  def test_renders_the_component_with_a_monospace_font
    render_inline(Primer::Alpha::TextField.new(**@default_params, monospace: true))

    assert_selector "input.FormControl-monospace"
  end

  def test_renders_a_leading_visual_icon
    render_inline(Primer::Alpha::TextField.new(**@default_params, leading_visual: { icon: :search }))

    assert_selector ".FormControl-input-leadingVisualWrap" do
      assert_selector "svg.octicon.octicon-search.FormControl-input-leadingVisual"
    end
  end
end
