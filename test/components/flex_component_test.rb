# frozen_string_literal: true

require "test_helper"

class PrimerFlexComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::FlexComponent.new) { "content" }

    assert_text("content")
  end

  def test_renders_as_d_flex
    render_inline(Primer::FlexComponent.new) { "content" }

    assert_selector(".d-flex")
  end

  def test_inline_defaults_to_false
    without_fetch_or_fallback_raises do
      render_inline(Primer::FlexComponent.new(inline: :grande)) { "content" }
    end

    assert_selector(".d-flex")
  end

  def test_flex_wrap_defaults_to_nil
    without_fetch_or_fallback_raises do
      render_inline(Primer::FlexComponent.new(flex_wrap: :grande)) { "content" }
    end

    refute_selector(".flex-wrap")
    refute_selector(".flex-nowrap")
  end

  def test_renders_flex_wrap_true
    render_inline(Primer::FlexComponent.new(flex_wrap: true)) { "content" }

    assert_selector(".flex-wrap")
  end

  def test_renders_flex_wrap_false
    render_inline(Primer::FlexComponent.new(flex_wrap: false)) { "content" }

    assert_selector(".flex-nowrap")
  end

  def test_renders_flex_wrap_nil
    render_inline(Primer::FlexComponent.new(flex_wrap: nil)) { "content" }

    refute_selector(".flex-wrap")
    refute_selector(".flex-nowrap")
  end

  def test_renders_align_items_center
    render_inline(Primer::FlexComponent.new(align_items: :center)) { "content" }

    assert_selector(".flex-items-center")
  end

  def test_align_items_falls_back_to_nil
    without_fetch_or_fallback_raises do
      render_inline(Primer::FlexComponent.new(align_items: :foo)) { "content" }
    end

    refute_selector(".flex-items-center")
  end

  def test_renders_as_d_inline_flex
    render_inline(Primer::FlexComponent.new(inline: true)) { "content" }

    assert_selector(".d-inline-flex")
  end

  def test_justify_content_falls_back_to_nil
    without_fetch_or_fallback_raises do
      render_inline(Primer::FlexComponent.new(justify_content: :grande)) { "content" }
    end

    refute_selector(".flex-justify-start")
  end

  def test_renders_justify_content
    render_inline(Primer::FlexComponent.new(justify_content: :center)) { "content" }

    assert_selector(".flex-justify-center")
  end

  def test_does_not_render_justify_content_if_nil
    render_inline(Primer::FlexComponent.new(justify_content: nil)) { "content" }

    refute_selector(".flex-justify-start")
  end

  def test_defaults_to_no_direction_when_invalid_direction_is_used
    render_inline(Primer::FlexComponent.new(direction: :invalid)) { "content" }

    refute_selector(".flex-row")
  end

  def test_renders_direction
    render_inline(Primer::FlexComponent.new(direction: :row)) { "content" }

    assert_selector(".flex-row")
  end

  def test_does_not_render_direction_if_nil
    render_inline(Primer::FlexComponent.new(direction: nil)) { "content" }

    refute_selector(".flex-row")
  end

  def test_renders_responsive_direction
    render_inline(Primer::FlexComponent.new(direction: %i[row column])) { "content" }

    assert_selector(".flex-row.flex-sm-column")
  end

  def test_warns_of_deprecation_if_not_silenced
    with_silence_deprecations(false) do
      ActiveSupport::Deprecation.expects(:warn).with("Primer::FlexComponent is deprecated and will be removed in v0.0.40. Use Primer::Box instead.").once
      Primer::FlexComponent.new
    end
  end
end
