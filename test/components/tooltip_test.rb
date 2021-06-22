# frozen_string_literal: true

require "test_helper"

class PrimerTooltipTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_with_defaults
    render_inline(Primer::Tooltip.new(label: "More")) { "Some" }

    assert_text("Some")
    assert_selector(".tooltipped")
  end

  def test_renders_with_a_direction
    render_inline(Primer::Tooltip.new(label: "More", direction: :nw)) { "Some" }

    assert_text("Some")
    assert_selector(".tooltipped.tooltipped-nw")
  end

  def test_renders_with_alignment
    render_inline(Primer::Tooltip.new(label: "More", align: :right_1)) { "Some" }

    assert_text("Some")
    assert_selector(".tooltipped.tooltipped-align-right-1")
  end

  def test_falls_back_when_tag_isnt_valid
    without_fetch_or_fallback_raises do
      render_inline(Primer::Tooltip.new(tag: :h5, label: "More")) { "Some" }
      assert_selector("span.tooltipped")
    end
  end

  def test_renders_with_no_delay
    render_inline(Primer::Tooltip.new(label: "More", no_delay: true)) { "Some" }

    assert_text("Some")
    assert_selector(".tooltipped.tooltipped-no-delay")
  end

  def test_renders_with_multiline
    render_inline(Primer::Tooltip.new(label: "More", multiline: true)) { "Some" }

    assert_text("Some")
    assert_selector(".tooltipped.tooltipped-multiline")
  end
end
