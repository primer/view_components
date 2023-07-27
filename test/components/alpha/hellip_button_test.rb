# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaHellipButtonTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::Alpha::HellipButton.new("aria-label": "No effect"))

    assert_selector("button[type='button'][aria-expanded='false']", text: "…")
  end

  def test_renders_inline
    render_inline(Primer::Alpha::HellipButton.new(inline: true, "aria-label": "No effect"))

    assert_selector("button[type='button'][aria-expanded='false'].inline", text: "…")
  end

  def test_renders_button_custom_classes
    render_inline(Primer::Alpha::HellipButton.new(classes: "custom-class", "aria-label": "No effect"))

    assert_selector("button[type='button'][aria-expanded='false'].custom-class", text: "…")
  end

  def test_renders_aria_label
    render_inline(Primer::Alpha::HellipButton.new("aria-label": "Custom aria label"))

    assert_selector("button[aria-label='Custom aria label']")
  end

  def test_renders_aria_label_provided_as_object
    render_inline(Primer::Alpha::HellipButton.new(aria: { label: "Custom aria label" }))

    assert_selector("button[aria-label='Custom aria label']")
  end

  def test_raises_if_no_aria_label_is_provided
    err = assert_raises ArgumentError do
      render_inline(Primer::Alpha::HellipButton.new)
    end

    assert_equal("`aria-label` or `aria-labelledby` is required.", err.message)
  end

  def test_does_not_render_content
    render_inline(Primer::Alpha::HellipButton.new("aria-label": "No effect")) { "content" }

    refute_text("content")
  end

  def test_disabled
    render_inline(Primer::Alpha::HellipButton.new(aria: { label: "Custom aria label" }, disabled: true))

    assert_selector("button[disabled]", text: "…")
  end
end
