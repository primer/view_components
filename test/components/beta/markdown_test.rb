# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaMarkdownTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_with_content
    render_inline(Primer::Beta::Markdown.new) { "Content" }

    assert_selector(".markdown-body", text: "Content")
  end

  def test_renders_with_article
    render_inline(Primer::Beta::Markdown.new(tag: :article)) { "Content" }

    assert_selector("article.markdown-body", text: "Content")
  end

  def test_renders_with_td
    render_inline(Primer::Beta::Markdown.new(tag: :td)) { "Content" }

    assert_selector("td.markdown-body", text: "Content")
  end

  def test_falls_back_when_tag_isnt_valid
    without_fetch_or_fallback_raises do
      render_inline(Primer::Beta::Markdown.new(tag: :h3)) { "Content" }
      assert_selector("div.markdown-body")
    end
  end
end
