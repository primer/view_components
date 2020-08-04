# frozen_string_literal: true

require "test_helper"

class PrimerBoxComponentTest < Minitest::Test
  include ViewComponent::TestHelpers

  def test_renders_content
    render_inline(Primer::BoxComponent.new) do
      "content"
    end

    assert_text("content")
  end

  def test_renders_div
    render_inline(Primer::BoxComponent.new) do
      "content"
    end

    assert_selector("div")
  end
end
