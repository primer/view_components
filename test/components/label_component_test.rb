# frozen_string_literal: true

require "test_helper"

class PrimerLabelComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::LabelComponent.new) { "private" }

    assert_text("private")
  end

  def test_falls_back_when_tag_isnt_valid
    without_fetch_or_fallback_raises do
      render_inline(Primer::LabelComponent.new(tag: :h1))
      assert_selector("span.Label")
    end
  end

  def test_supports_functional_schemes
    render_inline(Primer::LabelComponent.new(scheme: :danger)) { "private" }

    assert_selector(".Label--danger")
  end

  def test_deprecated_schemes
    Primer::LabelComponent::DEPRECATED_SCHEME_OPTIONS.each do |scheme|
      render_inline(Primer::LabelComponent.new(scheme: scheme)) { "scheme" }
    end
  end

  def test_falls_back_when_scheme_isn_t_valid
    without_fetch_or_fallback_raises do
      render_inline(Primer::LabelComponent.new(scheme: :pink)) { "content" }
    end

    assert_text("content")
  end

  def test_supports_sizes
    render_inline(Primer::LabelComponent.new(size: :large)) { "private" }

    assert_selector(".Label--large")
  end

  def test_falls_back_when_size_isn_t_valid
    without_fetch_or_fallback_raises do
      render_inline(Primer::LabelComponent.new(size: :small)) { "content" }
    end

    assert_text("content")
  end

  def test_renders_with_the_css_class_variant_mapping_to_the_provided_variant
    render_inline(Primer::LabelComponent.new(variant: :inline)) { "private" }

    assert_selector(".Label.Label--inline")
  end

  def test_falls_back_when_variant_isn_t_valid
    without_fetch_or_fallback_raises do
      render_inline(Primer::LabelComponent.new(variant: :special)) { "content" }
    end

    assert_text("content")
  end

  def test_status
    assert_component_state(Primer::LabelComponent, :beta)
  end
end
