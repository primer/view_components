# frozen_string_literal: true

require "components/test_helper"

class Primer::OpenProject::BorderBox::CollapsibleHeaderTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_default
    render_preview(:default)

    assert_selector(".CollapsibleHeader", text: "Default title")
    assert_selector("svg.up-icon")
    assert_selector("svg.down-icon.d-none")
    # Test for border style
  end

  def test_does_not_render_without_title_and_box
    render_inline(Primer::OpenProject::BorderBox::CollapsibleHeader.new)

    refute_component_rendered
  end

  def test_does_not_render_without_valid_box
    render_inline(Primer::OpenProject::BorderBox::CollapsibleHeader.new(title: "Test title", box: "Some component"))

    refute_component_rendered
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

    sleep(2) # More delay or something else?
    assert_selector(".CollapsibleHeader", text: "Default title")
    assert_selector("svg.up-icon.d-none")
    assert_selector("svg.down-icon")
    assert_no_text("This text should also be hidden when collapsed")
    # Test for border style
  end
end
