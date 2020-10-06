# frozen_string_literal: true

require "test_helper"

class PrimerOcticonComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_octicon_by_providing_icon_as_only_argument
    render_inline(Primer::OcticonComponent.new(icon: "star"))

    assert_selector(".octicon.octicon-star")
  end

  def test_renders_octicon_by_providing_icon_as_symbol_argument
    render_inline(Primer::OcticonComponent.new(icon: :star))

    assert_selector(".octicon.octicon-star")
  end

  def test_renders_aria_hidden_true_by_default
    render_inline(Primer::OcticonComponent.new(icon: "star"))

    assert_selector("[aria-hidden='true']")
  end

  def test_renders_aria_label_attribute
    render_inline(Primer::OcticonComponent.new(icon: "star", aria: { label: "star-label" }))

    assert_selector("[aria-label='star-label']")
  end

  def test_renders_style_argument
    render_inline(Primer::OcticonComponent.new(icon: "star", style: "margin-left: 100px"))

    assert_selector("[style='margin-left: 100px']")
  end

  def test_renders_default_size_small
    render_inline(Primer::OcticonComponent.new(icon: "star"))

    assert_selector("[height='16']")
  end

  def test_renders_the_provided_size
    render_inline(Primer::OcticonComponent.new(icon: "star", size: :large))

    assert_selector("[height='64']")
  end

  def test_renders_small_if_invalid_size_is_passed
    render_inline(Primer::OcticonComponent.new(icon: "star", size: :grande))

    assert_selector("[height='16']")
  end

  def test_renders_class_passed_in
    render_inline(Primer::OcticonComponent.new(icon: "star", class: "foo"))

    assert_selector(".foo")
  end

  def test_renders_classes_passed_in
    render_inline(Primer::OcticonComponent.new(icon: "star", classes: "foo"))

    assert_selector(".foo")
  end

  def test_renders_class_passed_in_along_with_primer_class
    render_inline(Primer::OcticonComponent.new(icon: "star", class: "foo", my: 4))

    assert_selector(".foo.my-4")
  end

  def test_renders_concatenated_class_and_classes_passed_in
    render_inline(Primer::OcticonComponent.new(icon: "star", class: "foo", classes: "bar"))

    assert_selector(".foo.bar")
  end

  def test_does_not_render_classify_attributes_as_html_attributes
    render_inline(Primer::OcticonComponent.new(icon: "star", classes: "foo", display: [:none]))

    refute_selector('[classes="foo"][display="none"]')
  end
end
