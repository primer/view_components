# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaProgressBarTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_if_no_items_provided
    render_inline(Primer::Beta::ProgressBar.new)

    refute_component_rendered
  end

  def test_renders_empty_bar_if_percentage_is_not_provided
    render_inline(Primer::Beta::ProgressBar.new, &:item)

    assert_selector("span.Progress .Progress-item")
  end

  def test_renders_large_option
    render_inline(Primer::Beta::ProgressBar.new(size: :large)) do |component|
      component.item(percentage: 80)
    end

    assert_selector("span.Progress--large.Progress")
  end

  def test_renders_default_when_invalid_size_arg_passed
    without_fetch_or_fallback_raises do
      render_inline(Primer::Beta::ProgressBar.new(size: "kittens"), &:item)

      assert_selector("span.Progress")
    end
  end

  def test_renders_percent_completed_progress
    render_inline(Primer::Beta::ProgressBar.new) do |component|
      component.item(percentage: 80)
    end

    assert_selector("[style='width: 80%;']")
  end

  def test_renders_custom_styles
    render_inline(Primer::Beta::ProgressBar.new) do |component|
      component.item(percentage: 80, style: "color: red")
    end

    assert_selector("[style='color: red;width: 80%;']")
  end

  def test_renders_background_colors
    render_inline(Primer::Beta::ProgressBar.new) do |component|
      component.item(bg: :danger)
    end

    assert_selector("span.Progress .Progress-item.color-bg-danger")
  end

  def test_status
    assert_component_state(Primer::Beta::ProgressBar, :beta)
  end
end
