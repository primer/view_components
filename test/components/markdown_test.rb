# frozen_string_literal: true

require "test_helper"

class PrimerMarkdownTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_with_content
    render_inline(Primer::Markdown.new) { "Content" }

    assert_selector(".markdown-body", text: "Content")
  end

  def test_renders_different_tags
    render_inline(Primer::Markdown.new(tag: :td)) { "Content" }

    assert_selector("td.markdown-body", text: "Content")
  end
end
