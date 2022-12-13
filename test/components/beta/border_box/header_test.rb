# frozen_string_literal: true

require "components/test_helper"

class Primer::Beta::BorderBox::HeaderTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::Beta::BorderBox::Header.new) { "Header" }

    assert_text("Header")
  end

  def test_renders_title
    render_inline(Primer::Beta::BorderBox::Header.new) do |header|
      header.with_title(tag: :h3) { "Title" }
    end

    assert_text("Title")
  end
end
