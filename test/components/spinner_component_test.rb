# frozen_string_literal: true

require "components/test_helper"

class PrimerSpinnerComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_an_svg
    render_inline(Primer::SpinnerComponent.new)

    assert_selector("svg")
  end

  def test_defaults_to_size_32
    render_inline(Primer::SpinnerComponent.new)

    assert_selector("svg[height=32][width=32]")
  end

  def test_size_small
    render_inline(Primer::SpinnerComponent.new(size: :small))

    assert_selector("svg[height=16][width=16]")
  end

  def test_size_large
    render_inline(Primer::SpinnerComponent.new(size: :large))

    assert_selector("svg[height=64][width=64]")
  end

  def test_defaults_to_box_sizing_style
    render_inline(Primer::SpinnerComponent.new)

    assert_selector("[style='box-sizing: content-box; color: var(--color-icon-primary);']")
  end

  def test_no_box_sizing_style
    render_inline(Primer::SpinnerComponent.new(style: nil))

    assert_no_selector("[style]")
  end

  def test_status
    assert_component_state(Primer::SpinnerComponent, :beta)
  end
end
