# frozen_string_literal: true

require "test_helper"

class PrimerIconButtonTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::IconButton.new(icon: :star, "aria-label": "Label"))

    assert_selector("button[aria-label='Label'].btn-octicon") do
      assert_selector(".octicon.octicon-star")
    end
  end

  def test_does_not_render_content
    render_inline(Primer::IconButton.new(icon: :star, "aria-label": "Label")) { "content" }

    refute_text("content")
  end

  def test_renders_as_a_tag
    render_inline(Primer::IconButton.new(tag: :a, icon: :star, "aria-label": "Label"))

    assert_selector("a[role='button'][aria-label='Label'].btn-octicon") do
      assert_selector(".octicon.octicon-star")
    end
  end

  def test_renders_as_summary_tag
    render_inline(Primer::IconButton.new(tag: :summary, icon: :star, "aria-label": "Label"))

    assert_selector("summary[aria-label='Label'].btn-octicon") do
      assert_selector(".octicon.octicon-star")
    end
  end

  def test_renders_danger_scheme
    render_inline(Primer::IconButton.new(icon: :star, "aria-label": "Label", scheme: :danger))

    assert_selector("button[aria-label='Label'].btn-octicon.btn-octicon-danger") do
      assert_selector(".octicon.octicon-star")
    end
  end

  def test_raises_if_no_aria_label_is_provided
    err = assert_raises ArgumentError do
      render_inline(Primer::IconButton.new(icon: :star))
    end

    assert_equal("`aria-label` is required.", err.message)
  end
end
