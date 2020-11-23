# frozen_string_literal: true

require "test_helper"

class PrimerLabelComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::LabelComponent.new(title: "private-badge")) { "private" }

    assert_text("private")
  end

  def test_defaults_to_bg_blue
    render_inline(Primer::LabelComponent.new(title: "foo")) { "private" }

    assert_selector(".bg-blue")
  end

  def test_supports_functional_schemes
    render_inline(Primer::LabelComponent.new(title: "foo", scheme: :danger)) { "private" }

    assert_selector(".Label--danger")
  end

  def test_falls_back_when_scheme_isn_t_valid
    render_inline(Primer::LabelComponent.new(title: "title", scheme: :pink)) { "content" }

    assert_text("content")
  end

  def test_renders_with_the_css_class_scheme_mapping_to_the_provided_scheme
    render_inline(Primer::LabelComponent.new(title: "title", scheme: :gray)) { "private" }

    assert_selector(".Label.Label--gray")
  end

  def test_renders_with_the_css_class_variant_mapping_to_the_provided_variant
    render_inline(Primer::LabelComponent.new(title: "title", variant: :large)) { "private" }

    assert_selector(".Label.Label--large")
  end

  def test_falls_back_when_variant_isn_t_valid
    without_fetch_or_fallback_raises do
      render_inline(Primer::LabelComponent.new(title: "title", variant: :xxl)) { "content" }
    end

    assert_text("content")
  end
end
