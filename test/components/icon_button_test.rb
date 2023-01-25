# frozen_string_literal: true

require "components/test_helper"

class PrimerIconButtonTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::IconButton.new(icon: :star, "aria-label": "Label"))

    assert_selector("button.btn-octicon") do
      assert_selector(".octicon.octicon-star")
      assert_selector("tool-tip", visible: false, text: "Label")
    end
    refute_selector(".Box-btn-octicon")
  end

  def test_does_not_render_content
    render_inline(Primer::IconButton.new(icon: :star, "aria-label": "Label")) { "content" }

    refute_text("content")
  end

  def test_renders_as_a_tag
    render_inline(Primer::IconButton.new(tag: :a, icon: :star, "aria-label": "Label"))

    assert_selector("a.btn-octicon") do
      assert_selector(".octicon.octicon-star")
      assert_selector("tool-tip", visible: false, text: "Label")
    end
  end

  def test_renders_as_summary_tag
    render_inline(Primer::IconButton.new(tag: :summary, icon: :star, "aria-label": "Label"))

    assert_selector("summary.btn-octicon") do
      assert_selector(".octicon.octicon-star")
      refute_selector("tool-tip", visible: false, text: "Label")
    end
  end

  def test_renders_danger_scheme
    render_inline(Primer::IconButton.new(icon: :star, "aria-label": "Label", scheme: :danger))

    assert_selector("button.btn-octicon.btn-octicon-danger") do
      assert_selector(".octicon.octicon-star")
      assert_selector("tool-tip", visible: false, text: "Label")
    end
  end

  def test_raises_if_no_aria_label_is_provided
    err = assert_raises ArgumentError do
      render_inline(Primer::IconButton.new(icon: :star))
    end

    assert_equal("`aria-label` or `aria-labelledby` is required.", err.message)
  end

  def test_does_not_raise_if_aria_label_is_provided_as_an_object
    render_inline(Primer::IconButton.new(icon: :star, aria: { label: "Label" }))

    assert_selector("button.btn-octicon") do
      assert_selector(".octicon.octicon-star")
      assert_selector("tool-tip", visible: false, text: "Label")
    end
  end

  def test_renders_in_a_border_box
    render_inline(Primer::IconButton.new(icon: :star, "aria-label": "Label", box: true))

    assert_selector("button.btn-octicon.Box-btn-octicon") do
      assert_selector(".octicon.octicon-star")
      assert_selector("tool-tip", visible: false, text: "Label")
    end
  end

  def test_renders_tooltip_with_description
    render_inline(Primer::IconButton.new(icon: :star, "aria-label": "Label", "aria-description": "Description"))

    assert_selector("button.btn-octicon") do
      assert_selector(".octicon.octicon-star")
      assert_selector("tool-tip", visible: false, text: "Description")
    end
  end

  def test_renders_tooltip_with_direction_n
    render_inline(Primer::IconButton.new(icon: :star, "aria-label": "Label", tooltip_direction: :n))

    assert_selector("button.btn-octicon") do
      assert_selector(".octicon.octicon-star")
      assert_selector("tool-tip[data-direction=\"n\"]", visible: false)
    end
  end
end
