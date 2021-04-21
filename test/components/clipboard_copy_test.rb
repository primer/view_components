# frozen_string_literal: true

require "test_helper"

class PrimerClipboardCopyTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_simple
    render_inline Primer::ClipboardCopy.new do |component|
      component.target do
        "Text to copy"
      end
    end

    assert_selector("div[id^=\"clipboard-copy-\"]") do |node|
      assert_equal(node.text.strip, "Text to copy")
    end
    assert_selector("clipboard-copy[for^=\"clipboard-copy-\"]") do
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

  def test_renders_with_target
    render_inline Primer::ClipboardCopy.new(id: "foo") do |component|
      component.target do
        "Text to copy"
      end

      "Click to copy!"
    end

    assert_selector("clipboard-copy[for=\"foo\"]") do |node|
      assert_equal(node.text.strip, "Click to copy!")
    end
    assert_selector("div[id=\"foo\"]") do |node|
      assert_equal(node.text.strip, "Text to copy")
    end
  end

  def test_renders_with_form_target
    render_inline Primer::ClipboardCopy.new(id: "foo") do |component|
      component.target(tag: :input, value: "Text to copy")

      "Click to copy!"
    end

    assert_selector("clipboard-copy[for=\"foo\"]") do |node|
      assert_equal(node.text.strip, "Click to copy!")
    end
    assert_selector("input[id=\"foo\"][value=\"Text to copy\"]")
  end

  def test_renders_with_link
    render_inline Primer::ClipboardCopy.new(id: "foo") do |component|
      component.target(tag: :a, href: "/path/to/copy") do
        "Some link"
      end

      "Click to copy link!"
    end

    assert_selector("clipboard-copy[for=\"foo\"]") do |node|
      assert_equal(node.text.strip, "Click to copy link!")
    end
    assert_selector("a[id=\"foo\"][href=\"/path/to/copy\"]")
  end

  def test_renders_with_random_id_if_one_isnt_supplied
    render_inline Primer::ClipboardCopy.new do |component|
      component.target do
        "Text to copy"
      end

      "Click to copy!"
    end

    assert_selector("clipboard-copy[for^=\"clipboard-copy-\"]") do |node|
      assert_equal(node.text.strip, "Click to copy!")
    end
    assert_selector("div[id^=\"clipboard-copy-\"]") do |node|
      assert_equal(node.text.strip, "Text to copy")
    end
  end
end
