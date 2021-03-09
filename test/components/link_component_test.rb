# frozen_string_literal: true

require "test_helper"

class PrimerLinkComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content_and_not_muted_link
    render_inline(Primer::LinkComponent.new(href: "http://joe-jonas-shirtless.com")) { "content" }

    assert_text("content")
    refute_selector(".Link--muted")
  end

  def test_renders_as_a_link
    render_inline(Primer::LinkComponent.new(href: "http://google.com")) { "content" }

    assert_selector("a[href='http://google.com']")
  end

  def test_renders_primer_classes
    render_inline(Primer::LinkComponent.new(href: "http://google.com", mr: 3, muted: true)) { "content" }

    assert_selector(".mr-3.Link--muted")
  end

  def test_defaults_muted_to_false
    without_fetch_or_fallback_raises do
      render_inline(Primer::LinkComponent.new(href: "http://google.com", muted: nil)) { "content" }
    end

    refute_selector(".Link--muted")
  end

  def test_renders_muted_and_custom_css_class
    render_inline(Primer::LinkComponent.new(href: "http://google.com", classes: "foo", muted: true)) { "content" }

    assert_selector(".foo.Link--muted")
  end

  def test_renders_no_underline
    render_inline(Primer::LinkComponent.new(href: "http://google.com", underline: false)) { "content" }

    assert_selector(".no-underline")
  end

  def test_status
    assert_component_state(Primer::LinkComponent, :beta)
  end
end
