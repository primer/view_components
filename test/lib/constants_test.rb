# frozen_string_literal: true

require "lib/test_helper"

class Primer::ViewComponents::ConstantsTest < Minitest::Test
  def test_get_array
    tag_options = Primer::ViewComponents::Constants.get(
      component: "Primer::Beta::BaseButton",
      constant: "TAG_OPTIONS"
    )

    assert_equal tag_options, %w[button a summary clipboard-copy]
  end

  def test_get_symbolizes_array_elements
    tag_options = Primer::ViewComponents::Constants.get(
      component: "Primer::Beta::BaseButton",
      constant: "TAG_OPTIONS",
      symbolize: true
    )

    assert_equal tag_options, %w[:button :a :summary :clipboard-copy]
  end

  def test_get_hash
    scheme_mappings = Primer::ViewComponents::Constants.get(
      component: "Primer::Alpha::ButtonMarketing",
      constant: "SCHEME_MAPPINGS"
    )

    assert_equal(
      scheme_mappings, {
        "btn-signup-mktg" => "primary",
        "btn-muted-mktg" => "outline",
        "btn-subtle-mktg" => "transparent"
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
        "primary" => "btn-signup-mktg",
        "outline" => "btn-muted-mktg",
        "transparent" => "btn-subtle-mktg"
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
        "btn-signup-mktg" => ":primary",
        "btn-muted-mktg" => ":outline",
        "btn-subtle-mktg" => ":transparent"
      }
    )
  end
end
