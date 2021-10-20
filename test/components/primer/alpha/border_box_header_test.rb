# frozen_string_literal: true

require "test_helper"

class PrimerAlphaBorderBox::HeaderTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::BorderBox::Header.new) { "Header" }

    assert_text("Header")
  end

  def test_renders_title
    render_inline(Primer::BorderBox::Header.new) do |h|
      h.title { "Title" }
    end

    assert_text("Title")
  end
end
