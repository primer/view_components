# frozen_string_literal: true

require "test_helper"

class PrimerBoxComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

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

  def test_status
    assert_equal Primer::BoxComponent.status, Primer::Component::STATUSES[:stable]
  end
end
