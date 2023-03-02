# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaLinkTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content_and_not_muted_link
    render_inline(Primer::Beta::Link.new(href: "http://joe-jonas-shirtless.com")) { "content" }

    assert_text("content")
    refute_selector(".Link--muted")
  end

  def test_renders_no_additional_whitespace
    result = render_inline(Primer::Beta::Link.new(href: "http://joe-jonas-shirtless.com")) { "content" }

    assert_match(%r{^<a[^>]+>content</a>$}, result.to_s)
  end

  def test_renders_without_trailing_newline
    render_inline(Primer::Beta::Link.new(href: "http://joe-jonas-shirtless.com")) { "content" }

    refute rendered_content.end_with?("\n")
  end

  def test_renders_as_a_link
    render_inline(Primer::Beta::Link.new(href: "http://google.com")) { "content" }

    assert_selector("a[href='http://google.com']")
  end

  def test_renders_primer_classes
    render_inline(Primer::Beta::Link.new(href: "http://google.com", mr: 3, muted: true)) { "content" }

    assert_selector(".mr-3.Link--muted")
  end

  def test_defaults_muted_to_false
    without_fetch_or_fallback_raises do
      render_inline(Primer::Beta::Link.new(href: "http://google.com", muted: nil)) { "content" }
    end

    refute_selector(".Link--muted")
  end

  def test_renders_muted_and_custom_css_class
    render_inline(Primer::Beta::Link.new(href: "http://google.com", classes: "foo", muted: true)) { "content" }

    assert_selector(".foo.Link--muted")
  end

  def test_renders_no_underline
    render_inline(Primer::Beta::Link.new(href: "http://google.com", underline: false)) { "content" }

    assert_selector(".no-underline")
  end

  def test_schemes
    render_inline(Primer::Beta::Link.new(href: "http://google.com", scheme: :primary)) { "content" }

    assert_selector(".Link--primary")

    render_inline(Primer::Beta::Link.new(href: "http://google.com", scheme: :secondary)) { "content" }

    assert_selector(".Link--secondary")
  end

  def test_span_as_a_link
    render_inline(Primer::Beta::Link.new(tag: :span)) { "content" }

    assert_selector(".Link")
  end

  def test_raises_if_a_tag_and_href_nil
    err = assert_raises ArgumentError do
      render_inline(Primer::Beta::Link.new(tag: :a)) { "content" }
    end

    assert_equal("href is required when using <a> tag", err.message)
  end

  def test_status
    assert_component_state(Primer::Beta::Link, :beta)
  end

  def test_renders_with_tooltip_sibling
    render_inline(Primer::Beta::Link.new(id: "1", href: "http://google.com")) do |component|
      component.with_tooltip(text: "Tooltip text")
      "content"
    end

    assert_selector("a[href='http://google.com'] + tool-tip", text: "Tooltip text", visible: false)
  end
end
