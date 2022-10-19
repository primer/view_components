# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaTextTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::Beta::Text.new) { "content" }

    assert_text("content")
  end

  def test_renders_span
    render_inline(Primer::Beta::Text.new) { "content" }

    assert_selector("span")
  end

  def test_renders_as_p
    render_inline(Primer::Beta::Text.new(tag: :p)) { "content" }

    assert_selector("p")
  end

  def test_status
    assert_component_state(Primer::Beta::Text, :beta)
  end
end
