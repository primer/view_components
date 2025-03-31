# frozen_string_literal: true

require "components/test_helper"

class Primer::OpenProject::BorderBox::CollapsibleHeaderTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_default
    render_preview(:default)

    assert_selector(".CollapsibleHeader", text: "Default title")
    assert_selector("svg.octicon.octicon-chevron-up")
    assert_selector("svg.octicon.octicon-chevron-down.d-none")
    # Test for border style
  end

  def test_does_not_render_without_title_and_box
    err = assert_raises ArgumentError do
      render_inline(Primer::OpenProject::BorderBox::CollapsibleHeader.new)
    end

    assert_equal "missing keywords: :title, :box", err.message
  end

  def test_does_not_render_without_valid_box
    err = assert_raises ArgumentError do
      render_inline(render_inline(Primer::OpenProject::BorderBox::CollapsibleHeader.new(title: "Test title", box: "Some component")))
    end

    assert_equal "This component must be called inside the header of a `Primer::Beta::BorderBox`", err.message
  end

  def test_renders_with_description
    render_preview(:with_description)

    assert_selector(".CollapsibleHeader .color-fg-subtle",
                    text: "This is the description text... Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.")
    assert_no_selector(".CollapsibleHeader .color-fg-subtle.d-none")
  end

  def test_renders_with_count
    render_preview(:with_count)

    assert_selector(".CollapsibleHeader .Counter", text: "42")
  end

  def test_renders_collapsed
    render_preview(:collapsed)

    sleep(15) # More delay or something else?
    assert_selector(".CollapsibleHeader.CollapsibleHeader--collapsed", text: "Default title")
    # Test for border style
  end
end
