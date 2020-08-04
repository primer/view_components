# frozen_string_literal: true

require "test_helper"

class PrimerTextComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::TextComponent.new) { "content" }

    assert_text("content")
  end

  def test_renders_span
    render_inline(Primer::TextComponent.new) { "content" }

    assert_selector("span")
  end

  def test_renders_as_p
    render_inline(Primer::TextComponent.new(tag: :p)) { "content" }

    assert_selector("p")
  end
end
