# frozen_string_literal: true

require "test_helper"

class PrimerTooltipComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::TooltipComponent.new(label: "tooltip")) { "content" }

    assert_selector("span.tooltipped[aria-label='tooltip']", text: "content")
  end

  def test_renders_different_tags
    render_inline(Primer::TooltipComponent.new(tag: :a, label: "tooltip")) { "content" }

    assert_selector("a.tooltipped[aria-label='tooltip']", text: "content")
  end

  def test_renders_multilined
    render_inline(Primer::TooltipComponent.new(label: "tooltip", multiline: true)) { "content" }

    assert_selector(".tooltipped.tooltipped-multiline[aria-label='tooltip']", text: "content")
  end

  def test_renders_with_no_delay
    render_inline(Primer::TooltipComponent.new(label: "tooltip", no_delay: true)) { "content" }

    assert_selector(".tooltipped.tooltipped-no-delay[aria-label='tooltip']", text: "content")
  end

  def test_defaults_to_north_direction
    render_inline(Primer::TooltipComponent.new(label: "tooltip")) { "content" }

    assert_selector(".tooltipped.tooltipped-n[aria-label='tooltip']", text: "content")
  end

  def test_fallbacks_to_north_direction
    without_fetch_or_fallback_raises do
      render_inline(Primer::TooltipComponent.new(label: "tooltip", direction: :invalid)) { "content" }
    end

    assert_selector(".tooltipped.tooltipped-n[aria-label='tooltip']", text: "content")
  end

  def test_renders_different_directions
    render_inline(Primer::TooltipComponent.new(label: "tooltip", direction: :s)) { "content" }

    assert_selector(".tooltipped.tooltipped-s[aria-label='tooltip']", text: "content")
  end

  def test_defaults_to_no_alignment
    render_inline(Primer::TooltipComponent.new(label: "tooltip")) { "content" }

    refute_selector(".tooltipped-align-right-1")
    refute_selector(".tooltipped-align-left-1")
  end

  def test_fallbacks_to_no_alignment
    without_fetch_or_fallback_raises do
      render_inline(Primer::TooltipComponent.new(label: "tooltip", align: :invalid)) { "content" }
    end

    refute_selector(".tooltipped-align-right-1")
    refute_selector(".tooltipped-align-left-1")
  end

  def test_aligns_to_left
    render_inline(Primer::TooltipComponent.new(label: "tooltip", align: :left)) { "content" }

    assert_selector(".tooltipped.tooltipped-align-left-1[aria-label='tooltip']", text: "content")
  end

  def test_aligns_to_right
    render_inline(Primer::TooltipComponent.new(label: "tooltip", align: :right)) { "content" }

    assert_selector(".tooltipped.tooltipped-align-right-1[aria-label='tooltip']", text: "content")
  end
end
