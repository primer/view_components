# frozen_string_literal: true

require "test_helper"

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

  def test_sets_size_height_and_width
    render_inline(Primer::SpinnerComponent.new(size: 16))

    assert_selector("svg[height=16][width=16]")
  end
end
