# frozen_string_literal: true

require "test_helper"

class PrimerClipboardCopyTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_simple
    render_inline Primer::ClipboardCopy.new(value: "Text to copy")

    assert_selector("clipboard-copy") do
      assert_selector("svg[class=\"octicon octicon-clippy\"]")
      assert_selector("svg[style=\"display: none;\"][class=\"octicon octicon-check color-icon-success\"]", { visible: false })
    end
  end

  def test_renders_with_text_contents
    render_inline Primer::ClipboardCopy.new(value: "Text to copy") do
      "Click to copy!"
    end

    assert_selector("clipboard-copy[value=\"Text to copy\"]") do |node|
      assert_equal(node.text.strip, "Click to copy!")
    end
  end
end
