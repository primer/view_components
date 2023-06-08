# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaButtonMarketingTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::Alpha::ButtonMarketing.new) { "content" }

    assert_selector("button.btn-mktg", text: "content")
  end

  def test_defaults_button_tag_with_scheme
    render_inline(Primer::Alpha::ButtonMarketing.new) { "content" }

    assert_selector("button.btn-mktg[type='button']")
  end

  def test_renders_a_without_button_role
    render_inline(Primer::Alpha::ButtonMarketing.new(tag: :a)) { "content" }

    assert_selector("a.btn-mktg")
    refute_selector("a.btn-mktg[role='button']")
  end

  def test_renders_href
    render_inline(Primer::Alpha::ButtonMarketing.new(href: "www.example.com")) { "content" }

    assert_selector("button[href='www.example.com']")
  end

  def test_renders_with_the_css_class_mapping_to_the_provided_type
    render_inline(Primer::Alpha::ButtonMarketing.new(scheme: :primary)) { "content" }

    assert_selector(".btn-mktg.btn-signup-mktg")
  end

  def test_renders_with_the_css_class_variant_mapping_to_the_provided_variant
    render_inline(Primer::Alpha::ButtonMarketing.new(variant: :large)) { "content" }

    assert_selector(".btn-mktg.btn-large-mktg")
  end

  def test_forces_button_tag_when_disabled
    render_inline(Primer::Alpha::ButtonMarketing.new(tag: :a, disabled: true)) { "content" }

    assert_selector("button.btn-mktg[disabled][aria-disabled=true]")
  end
end
