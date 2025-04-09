# frozen_string_literal: true

require "components/test_helper"

class Primer::OpenProject::BorderBox::CollapsibleHeaderTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_default
    render_preview(:default)

    assert_selector(".CollapsibleHeader", text: "Backlog")
    assert_selector("svg.octicon.octicon-chevron-up")
    assert_selector("svg.octicon.octicon-chevron-down.d-none")
  end

  def test_does_not_render_without_box
    err = assert_raises ArgumentError do
      render_inline(Primer::OpenProject::BorderBox::CollapsibleHeader.new)
    end

    assert_equal "missing keyword: :box", err.message
  end

  def test_does_not_render_without_valid_box
    err = assert_raises ArgumentError do
      render_inline(Primer::OpenProject::BorderBox::CollapsibleHeader.new(box: "Some component")) do |header|
        header.with_title { "Test title" }
      end
    end

    assert_equal "This component must be called inside the header of a `Primer::Beta::BorderBox`", err.message
  end

  def test_does_not_render_with_empty_title
    err = assert_raises ArgumentError do
      render_inline(Primer::OpenProject::BorderBox::CollapsibleHeader.new(box: "Some component"))
    end

    assert_equal "Title must be present", err.message
  end

  def test_renders_with_description
    render_preview(:with_description)

    assert_selector(".CollapsibleHeader .color-fg-subtle",
                    text: "This backlog is unique to this one-time meeting. You can drag items in and out to add or remove them from the meeting agenda.")
    assert_no_selector(".CollapsibleHeader .color-fg-subtle.d-none")
  end

  def test_renders_with_count
    render_preview(:with_count)

    assert_selector(".CollapsibleHeader .Counter", text: "42")
  end

  def test_renders_collapsed
    render_preview(:collapsed)

    assert_selector(".CollapsibleHeader.CollapsibleHeader--collapsed", text: "Backlog")
  end
end
