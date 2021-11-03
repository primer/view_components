# frozen_string_literal: true

require "test_helper"

class Primer::Alpha::BorderBox::HeaderTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::Alpha::BorderBox::Header.new) { "Header" }

    assert_text("Header")
  end

  def test_renders_title
    render_inline(Primer::Alpha::BorderBox::Header.new) do |h|
      h.title(tag: :h3) { "Title" }
    end

    assert_text("Title")
  end
end
