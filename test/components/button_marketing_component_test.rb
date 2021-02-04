# frozen_string_literal: true

require "test_helper"

class PrimerButtonMarketingComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::ButtonMarketingComponent.new) { "content" }

    assert_selector("button.btn-mktg", text: "content")
  end

  def test_defaults_button_tag_with_button_type
    render_inline(Primer::ButtonMarketingComponent.new) { "content" }

    assert_selector("button.btn-mktg[type='button']")
  end

  def test_renders_a_as_a_button
    render_inline(Primer::ButtonMarketingComponent.new(tag: :a)) { "content" }

    assert_selector("a.btn-mktg[role='button']")
  end

  def test_renders_href
    render_inline(Primer::ButtonMarketingComponent.new(href: "www.example.com")) { "content" }

    assert_selector("button[href='www.example.com']")
  end

  def test_renders_with_the_css_class_mapping_to_the_provided_type
    render_inline(Primer::ButtonMarketingComponent.new(button_type: :primary)) { "content" }

    assert_selector(".btn-mktg.btn-primary-mktg")
  end

  def test_renders_with_the_css_class_variant_mapping_to_the_provided_variant
    render_inline(Primer::ButtonMarketingComponent.new(variant: :large)) { "content" }

    assert_selector(".btn-mktg.btn-large-mktg")
  end
end
