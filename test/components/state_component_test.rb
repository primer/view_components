# frozen_string_literal: true

require "test_helper"

class PrimerStateComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_color_falls_back_to_default
    without_fetch_or_fallback_raises do
      render_inline(Primer::StateComponent.new(title: "title", color: :chartreuse)) { "foo" }
    end

    assert_text("foo")
  end

  def test_as_falls_back_to_default
    without_fetch_or_fallback_raises do
      render_inline(Primer::StateComponent.new(title: "title", tag: :table)) { "foo" }
    end

    assert_selector("span")
  end

  def test_size_falls_back_to_default
    without_fetch_or_fallback_raises do
      render_inline(Primer::StateComponent.new(title: "title", color: :green, size: :big)) { "foo" }
    end

    assert_text("foo")
  end

  def test_renders_with_the_default_css_class_applied
    render_inline(Primer::StateComponent.new(title: "title")) { "foo" }

    assert_selector(".State")
  end

  def test_renders_with_the_css_class_mapping_to_the_provided_size
    render_inline(Primer::StateComponent.new(title: "title", size: :small)) { "foo" }

    assert_selector(".State--small")
  end

  def test_renders_with_the_css_class_mapping_to_the_provided_color
    render_inline(Primer::StateComponent.new(title: "title", color: :green)) { "foo" }

    assert_selector(".State--open")
  end

  def test_applies_additional_classes_to_the_underlying_element_when_given_class_names
    render_inline(
      Primer::StateComponent.new(title: "title", classes: "additional class-names here")
    ) { "foo" }

    assert_selector(".State.additional.class-names.here")
  end

  def test_applies_additional_classes_to_the_underlying_element_when_given_custom_color_size_and_class_names
    render_inline(
      Primer::StateComponent.new(title: "title", color: :red, size: :small, classes: "additional class-names here")
    ) { "foo" }

    assert_selector(".State.State--closed.State--small.additional.class-names.here")
  end

  def test_supports_functional_colors
    render_inline(Primer::StateComponent.new(title: "foo", color: :merged)) { "Merged" }

    assert_selector(".State--merged")
  end
end
