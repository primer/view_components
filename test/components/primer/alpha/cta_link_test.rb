# frozen_string_literal: true

require "test_helper"

class PrimerAlphaCtaLinkTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_without_content
    render_inline(Primer::Alpha::CtaLink.new(href: "#"))

    refute_component_rendered
  end

  def test_renders_an_anchor_with_content_and_caret
    render_inline(Primer::Alpha::CtaLink.new(href: "#")) { "content" }

    assert_selector("a[href='#'].btn") do
      assert_text("content")
      assert_selector(".octicon.octicon-chevron-right")
    end
  end

  def test_renders_a_without_button_role
    render_inline(Primer::Alpha::CtaLink.new(href: "#")) { "content" }

    refute_selector("a.btn[role='button']")
    refute_selector("a[type]")
  end

  def test_renders_with_the_css_class_mapping_to_the_provided_scheme
    Primer::Alpha::CtaLink::SCHEME_MAPPINGS.each do |scheme, css|
      next if scheme == :default

      render_inline(Primer::Alpha::CtaLink.new(href: "#", scheme: scheme)) { "content" }

      assert_selector("a.btn.#{css}")
    end
  end

  def test_falls_back_when_size_isn_t_valid
    without_fetch_or_fallback_raises do
      render_inline(Primer::Alpha::CtaLink.new(href: "#", size: :invalid)) { "content" }

      assert_selector("a.btn")
    end
  end

  def test_renders_with_the_css_class_size_mapping_to_the_provided_size
    render_inline(Primer::Alpha::CtaLink.new(href: "#", size: :small)) { "content" }

    assert_selector("a.btn.btn-sm")
  end

  def test_renders_button_block
    render_inline(Primer::Alpha::CtaLink.new(href: "#", block: true)) { "content" }

    assert_selector("a.btn.btn-block")
  end

  def test_renders_button_block_with_scheme
    render_inline(Primer::Alpha::CtaLink.new(href: "#", block: true, scheme: :primary)) { "content" }

    assert_selector("a.btn.btn-primary.btn-block")
  end
end
