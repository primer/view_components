# frozen_string_literal: true

require "test_helper"

class Primer::ViewComponents::ConstantsTest < Minitest::Test
  def test_get_array
    tag_options = Primer::ViewComponents::Constants.get(
      component: "Primer::BaseButton",
      constant: "TAG_OPTIONS"
    )

    assert_equal tag_options, %w[button a summary]
  end

  def test_get_symbolizes_array_elements
    tag_options = Primer::ViewComponents::Constants.get(
      component: "Primer::BaseButton",
      constant: "TAG_OPTIONS",
      symbolize: true
    )

    assert_equal tag_options, %w[:button :a :summary]
  end

  def test_get_hash
    scheme_mappings = Primer::ViewComponents::Constants.get(
      component: "Primer::Alpha::ButtonMarketing",
      constant: "SCHEME_MAPPINGS"
    )

    assert_equal(
      scheme_mappings, {
        "btn-primary-mktg" => "primary",
        "btn-outline-mktg" => "outline",
        "btn-transparent" => "transparent"
      }
    )
  end

  def test_get_hash_not_inverted
    scheme_mappings = Primer::ViewComponents::Constants.get(
      component: "Primer::Alpha::ButtonMarketing",
      constant: "SCHEME_MAPPINGS",
      invert: false
    )

    assert_equal(
      scheme_mappings, {
        "default" => "",
        "primary" => "btn-primary-mktg",
        "outline" => "btn-outline-mktg",
        "transparent" => "btn-transparent"
      }
    )
  end

  def test_get_symbolizes_hash_values
    scheme_mappings = Primer::ViewComponents::Constants.get(
      component: "Primer::Alpha::ButtonMarketing",
      constant: "SCHEME_MAPPINGS",
      symbolize: true
    )

    assert_equal(
      scheme_mappings, {
        "btn-primary-mktg" => ":primary",
        "btn-outline-mktg" => ":outline",
        "btn-transparent" => ":transparent"
      }
    )
  end
end
