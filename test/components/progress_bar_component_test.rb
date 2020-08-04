# frozen_string_literal: true

require "test_helper"

class Primer::ProgressBarComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_empty_bar_if_progress_is_not_provided
    render_inline(Primer::ProgressBarComponent.new)

    assert_selector("span.Progress")
  end

  def test_renders_large_option
    render_inline(Primer::ProgressBarComponent.new(size: :large))

    assert_selector("span.Progress--large.Progress")
  end

  def test_renders_default_when_invalid_size_arg_passed
    without_fetch_or_fallback_raises do
      render_inline(Primer::ProgressBarComponent.new(size: :kittens))
    end

    assert_selector("span.Progress")
  end

  def test_renders_percent_completed_progress
    render_inline(Primer::ProgressBarComponent.new(percentage: 80))

    assert_selector("[style='width: 80%;']")
  end
end
