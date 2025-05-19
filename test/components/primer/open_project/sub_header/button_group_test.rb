# frozen_string_literal: true

require "components/test_helper"

class Primer::OpenProject::SubHeader::ButtonGroupTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::SubHeader::ButtonGroup.new) do |group|
      group.with_button(icon: :note, "aria-label": "Button 1")
      group.with_button(icon: :rows, "aria-label": "Button 2")
      group.with_button(icon: "sort-desc", "aria-label": "Button 3")
    end

    assert_text("Button 1")
    assert_text("Button 2")
    assert_text("Button 3")
  end

  def test_does_not_render_without_icon
    err = assert_raises ArgumentError do
      render_inline(Primer::OpenProject::SubHeader::ButtonGroup.new) do |group|
        group.with_button("aria-label": "Button 1")
        group.with_button("aria-label": "Button 2")
        group.with_button("aria-label": "Button 3")
      end
    end

    assert_equal "missing keyword: :icon", err.message
  end
end
