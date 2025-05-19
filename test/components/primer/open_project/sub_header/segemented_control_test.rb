# frozen_string_literal: true

require "components/test_helper"

class Primer::OpenProject::SubHeader::SegmentedControlTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::SubHeader::SegmentedControl.new("aria-label": "Segmented control")) do |control|
      control.with_item(tag: :a, href: "#", label: "Preview", icon: :eye, selected: true)
      control.with_item(tag: :a, href: "#", label: "Raw", icon: :"file-code")
    end

    assert_text("Preview")
    assert_text("Raw")
  end

  def test_does_not_render_without_icon
    err = assert_raises ArgumentError do
      render_inline(Primer::OpenProject::SubHeader::SegmentedControl.new("aria-label": "Segmented control")) do |control|
        control.with_item(tag: :a, href: "#", label: "Preview", selected: true)
        control.with_item(tag: :a, href: "#", label: "Raw")
      end
    end

    assert_equal "missing keyword: :icon", err.message
  end
end
