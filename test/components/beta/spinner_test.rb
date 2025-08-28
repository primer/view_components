# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaSpinnerTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_an_svg
    render_inline(Primer::Beta::Spinner.new)

    assert_selector("svg")
  end

  def test_defaults_to_size_32
    render_inline(Primer::Beta::Spinner.new)

    assert_selector("svg[height=32][width=32]")
  end

  def test_size_small
    render_inline(Primer::Beta::Spinner.new(size: :small))

    assert_selector("svg[height=16][width=16]")
  end

  def test_size_large
    render_inline(Primer::Beta::Spinner.new(size: :large))

    assert_selector("svg[height=64][width=64]")
  end

  def test_defaults_to_box_sizing_style
    render_inline(Primer::Beta::Spinner.new)

    assert_selector("[style='box-sizing: content-box; color: var(--color-icon-primary);']")
  end

  def test_no_box_sizing_style
    render_inline(Primer::Beta::Spinner.new(style: nil))

    assert_no_selector("[style]")
  end

  def test_status
    assert_component_state(Primer::Beta::Spinner, :beta)
  end

  def test_adds_default_sr_span
    render_inline(Primer::Beta::Spinner.new)

    assert_selector("span.sr-only", text: "Loading")
  end

  def test_adds_custom_sr_span
    render_inline(Primer::Beta::Spinner.new(sr_text: "Custom Loading"))

    assert_selector("span.sr-only", text: "Custom Loading")
  end

  def test_no_custom_sr_span_with_aria_label
    render_inline(Primer::Beta::Spinner.new("aria-label": "Aria label"))

    assert_no_selector("span.sr-only")
  end

  def test_no_custom_sr_span_with_aria_label_hash
    render_inline(Primer::Beta::Spinner.new(aria: { label: "Aria label" }))

    assert_no_selector("span.sr-only")
  end

  def test_no_custom_sr_span_with_aria_labelledby
    render_inline(Primer::Beta::Spinner.new("aria-labelledby": "my_id"))

    assert_no_selector("span.sr-only")
  end

  def test_no_custom_sr_span_with_aria_labelledby_hash
    render_inline(Primer::Beta::Spinner.new(aria: { labelledby: "my_id" }))

    assert_no_selector("span.sr-only")
  end

  def test_adds_img_role_with_aria_label
    render_inline(Primer::Beta::Spinner.new("aria-label": "Aria label"))

    assert_selector("svg[role=img]")
  end

  def test_adds_aria_hidden_with_no_aria_label
    render_inline(Primer::Beta::Spinner.new)

    assert_selector("svg[aria-hidden=true]")
  end
end
