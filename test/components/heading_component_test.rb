# frozen_string_literal: true

require "test_helper"

class PrimerHeadingComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::HeadingComponent.new(tag: :h1)) { "content" }

    assert_text("content")
  end

  def test_falls_back_when_tag_isnt_valid
    without_fetch_or_fallback_raises do
      render_inline(Primer::HeadingComponent.new(tag: :div)) { "content" }

      assert_selector("h2")
    end
  end

  def test_renders_h1
    render_inline(Primer::HeadingComponent.new(tag: :h1)) { "content" }

    assert_selector("h1")
  end

  def test_renders_h3
    render_inline(Primer::HeadingComponent.new(tag: :h3)) { "content" }

    assert_selector("h3")
  end

  def test_status
    assert_component_state(Primer::HeadingComponent, :beta)
  end
end
