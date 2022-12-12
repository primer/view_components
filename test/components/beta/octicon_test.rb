# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaOcticonTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_octicon_by_providing_icon_as_only_argument
    render_inline(Primer::Beta::Octicon.new(:star))

    assert_selector(".octicon.octicon-star")
  end

  def test_renders_octicon_by_providing_icon_as_keyword_argument
    render_inline(Primer::Beta::Octicon.new(icon: :star))

    assert_selector(".octicon.octicon-star")
  end

  def test_renders_octicon_by_providing_icon_as_symbol_argument
    render_inline(Primer::Beta::Octicon.new(:star))

    assert_selector(".octicon.octicon-star")
  end

  def test_renders_aria_hidden_true_by_default
    render_inline(Primer::Beta::Octicon.new(:star))

    assert_selector("[aria-hidden='true']")
  end

  def test_renders_aria_label_attribute
    render_inline(Primer::Beta::Octicon.new(:star, aria: { label: "star-label" }))

    assert_selector("[aria-label='star-label'][role='img']")
    refute_selector("[aria-hidden='true']")
  end

  def test_renders_aria_label_as_string_argument
    render_inline(Primer::Beta::Octicon.new(:star, "aria-label": "star-label"))

    assert_selector("[aria-label='star-label'][role='img']")
    refute_selector("[aria-hidden='true']")
  end

  def test_renders_style_argument
    render_inline(Primer::Beta::Octicon.new(:star, style: "margin-left: 100px"))

    assert_selector("[style='margin-left: 100px']")
  end

  def test_renders_size_small_when_height_is_less_than_small
    render_inline(Primer::Beta::Octicon.new(:star, height: 12))

    assert_selector("[height='16']")
  end

  def test_renders_size_small_when_width_is_less_than_small
    render_inline(Primer::Beta::Octicon.new(:star, width: 12))

    assert_selector("[height='16']")
  end

  def test_renders_default_size_small
    render_inline(Primer::Beta::Octicon.new(:star))

    assert_selector("[height='16']")
  end

  def test_renders_the_provided_size
    render_inline(Primer::Beta::Octicon.new(:star, size: :medium))

    assert_selector("[height='24']")
  end

  def test_renders_with_overridden_height_and_width_despite_given_a_size
    render_inline(Primer::Beta::Octicon.new(:star, size: :medium, height: 33, width: 47))

    assert_selector('[height="33"][width="47"]')
  end

  def test_renders_classes_passed_in
    render_inline(Primer::Beta::Octicon.new(:star, classes: "foo"))

    assert_selector(".foo")
  end

  def test_renders_classes_passed_in_along_with_primer_class
    render_inline(Primer::Beta::Octicon.new(:star, classes: "foo", my: 4))

    assert_selector(".foo.my-4")
  end

  def test_does_not_render_classify_attributes_as_html_attributes
    render_inline(Primer::Beta::Octicon.new(:star, classes: "foo", display: [:none]))

    refute_selector('[classes="foo"]')
    refute_selector('[display="none"]')
  end

  def test_status
    assert_component_state(Primer::Beta::Octicon, :beta)
  end

  def test_renders_test_selector
    render_inline(Primer::Beta::Octicon.new(:star, test_selector: "bar"))

    refute_selector("[test_selector='bar']")
    assert_selector("[data-test-selector='bar']")
  end

  def test_renders_path_data
    render_inline(Primer::Beta::Octicon.new(:star))

    assert_selector("svg.octicon-star path[d]")
  end

  def test_renders_use_tag
    render_inline(Primer::Beta::Octicon.new(:star, use_symbol: true))

    assert_selector("svg.octicon-star use[href='#octicon_star_16']")
  end
end
