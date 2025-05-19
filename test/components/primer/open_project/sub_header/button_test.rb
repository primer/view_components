# frozen_string_literal: true

require "components/test_helper"

class Primer::OpenProject::SubHeader::ButtonTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::SubHeader::Button.new(icon: :star)) do
      "Hello World"
    end

    assert_selector("button") do
      assert_selector(".octicon.octicon-star")
      assert_text("Hello World")
    end
  end

  def test_does_not_render_without_icon
    err = assert_raises ArgumentError do
      render_inline(Primer::OpenProject::SubHeader::Button.new)
    end

    assert_equal "missing keyword: :icon", err.message
  end

  def test_does_not_render_with_a_leading_icon_slot
    err = assert_raises ArgumentError do
      render_inline(Primer::OpenProject::SubHeader::Button.new(icon: :star)) do |button|
        button.with_leading_visual_icon(icon: :star)
        "Hello World"
      end
    end

    assert_equal "Do not use the leading_visual_icon slot within the SubHeader, as it is reserved. Instead provide a leading_icon within the subHeader button slot", err.message
  end
end
