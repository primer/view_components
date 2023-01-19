# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaStateTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_scheme_falls_back_to_default
    without_fetch_or_fallback_raises do
      render_inline(Primer::Beta::State.new(title: "title", scheme: :chartreuse)) { "foo" }
    end

    assert_text("foo")
  end

  def test_as_falls_back_to_default
    without_fetch_or_fallback_raises do
      render_inline(Primer::Beta::State.new(title: "title", tag: :table)) { "foo" }
    end

    assert_selector("span")
  end

  def test_size_falls_back_to_default
    without_fetch_or_fallback_raises do
      render_inline(Primer::Beta::State.new(title: "title", scheme: :green, size: :big)) { "foo" }
    end

    assert_text("foo")
  end

  def test_renders_with_the_default_css_class_applied
    render_inline(Primer::Beta::State.new(title: "title")) { "foo" }

    assert_selector(".State")
  end

  def test_renders_with_the_css_class_mapping_to_the_provided_size
    render_inline(Primer::Beta::State.new(title: "title", size: :small)) { "foo" }

    assert_selector(".State--small")
  end

  def test_renders_with_the_css_class_mapping_to_the_provided_scheme
    render_inline(Primer::Beta::State.new(title: "title", scheme: :green)) { "foo" }

    assert_selector(".State--open")
  end

  def test_applies_additional_classes_to_the_underlying_element_when_given_class_names
    render_inline(
      Primer::Beta::State.new(title: "title", classes: "additional class-names here")
    ) { "foo" }

    assert_selector(".State.additional.class-names.here")
  end

  def test_applies_additional_classes_to_the_underlying_element_when_given_custom_scheme_size_and_class_names
    render_inline(
      Primer::Beta::State.new(title: "title", scheme: :red, size: :small, classes: "additional class-names here")
    ) { "foo" }

    assert_selector(".State.State--closed.State--small.additional.class-names.here")
  end

  def test_supports_functional_schemes
    render_inline(Primer::Beta::State.new(title: "foo", scheme: :merged)) { "Merged" }

    assert_selector(".State--merged")
  end

  def test_status
    assert_component_state(Primer::Beta::State, :beta)
  end
end
