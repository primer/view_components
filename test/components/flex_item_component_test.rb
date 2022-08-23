# frozen_string_literal: true

require "test_helper"

class PrimerFlexItemComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::FlexItemComponent.new) { "content" }

    assert_text("content")
  end

  def test_renders_flex_auto_class
    render_inline(Primer::FlexItemComponent.new(flex_auto: true)) { "content" }

    assert_selector(".flex-auto")
  end

  def test_flex_auto_falls_back_to_false
    without_fetch_or_fallback_raises do
      render_inline(Primer::FlexItemComponent.new(flex_auto: :grande)) { "content" }
    end

    refute_selector(".flex-auto")
  end

  def test_warns_of_deprecation_if_not_silenced
    with_silence_deprecations(false) do
      ActiveSupport::Deprecation.expects(:warn).with("Primer::FlexItemComponent is deprecated and will be removed in v0.0.40. Use Primer::Box instead.").once
      Primer::FlexItemComponent.new
    end
  end
end
