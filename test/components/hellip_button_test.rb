# frozen_string_literal: true

require "test_helper"

class PrimerHellipButtonTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::HellipButton.new("aria-label": "No effect"))

    assert_selector("button[type='button'][aria-expanded='false']", text: "…")
  end

  def test_renders_inline
    render_inline(Primer::HellipButton.new(inline: true, "aria-label": "No effect"))

    assert_selector("button[type='button'][aria-expanded='false']", text: "…")
  end

  def test_renders_button_custom_classes
    render_inline(Primer::HellipButton.new(classes: "custom-class", "aria-label": "No effect"))

    assert_selector("button[type='button'][aria-expanded='false'].custom-class", text: "…")
  end

  def test_does_not_render_content
    render_inline(Primer::HellipButton.new("aria-label": "No effect")) { "content" }

    refute_text("content")
  end
end
