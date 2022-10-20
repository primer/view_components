# frozen_string_literal: true

require "components/test_helper"

class PrimerBoxTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::Box.new) do
      "content"
    end

    assert_text("content")
  end

  def test_renders_div
    render_inline(Primer::Box.new) do
      "content"
    end

    assert_selector("div")
  end

  def test_status
    assert_component_state(Primer::Box, :stable)
  end
end
