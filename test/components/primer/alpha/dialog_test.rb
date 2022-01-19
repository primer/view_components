# frozen_string_literal: true

require "test_helper"

class PrimerAlphaDialogTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::Alpha::Dialog.new(title: "Title")) do |c|
      c.body { "content" }
    end

    assert_selector("modal-dialog[role='dialog']") do
      assert_selector("div", text: "content")
    end
  end

  # Complain about missing title
  def test_raises_on_missing_title
    error = assert_raises(ArgumentError) do
      render_inline(Primer::Alpha::Dialog.new)
    end

    assert_includes(error.message, "missing keyword:")
    assert_includes(error.message, "title")
  end

  # Sets title
  def test_renders_title
    render_inline(Primer::Alpha::Dialog.new(title: "Title")) do |c|
      c.body { "content" }
    end

    assert_selector("modal-dialog[role='dialog']") do
      assert_selector("h1", text: "Title")
    end
  end

    # Sets id
    def test_renders_title
      render_inline(Primer::Alpha::Dialog.new(title: "Title", dialog_id: "my-id")) do |c|
        c.body { "content" }
      end
  
      assert_selector("modal-dialog[id='my-id']")
    end

  # Doesn't add description if not present
  def test_does_not_render_description
    render_inline(Primer::Alpha::Dialog.new(title: "Title")) do |c|
      c.body { "content" }
    end

    assert_selector("modal-dialog[role='dialog']") do
      refute_selector("h2")
    end
  end

  # Sets description if present
  def test_renders_description
    render_inline(Primer::Alpha::Dialog.new(title: "Title", description: "Description")) do |c|
      c.body { "content" }
    end

    assert_selector("modal-dialog[role='dialog']") do
      assert_selector("h2", text: "Description")
    end
  end

  # Doesn't add buttons or footer if not present
  def test_does_not_render_button
    render_inline(Primer::Alpha::Dialog.new(title: "Title")) do |c|
      c.body { "content" }
    end

    assert_selector("modal-dialog[role='dialog']") do
      refute_selector("footer") do
        refute_selector("button")
      end
    end
  end

  # Adds buttons if present
  def test_renders_buttons
    render_inline(Primer::Alpha::Dialog.new(title: "Title")) do |c|
      c.button { "Button 1" }
      c.button { "Button 2" }
      c.body { "content" }
    end

    assert_selector("modal-dialog[role='dialog']") do
      assert_selector("footer") do
        assert_selector("button", text: "Button 1")
        assert_selector("button", text: "Button 2")
      end
    end
  end

  # Test renders close button
  def test_renders_close_button
    render_inline(Primer::Alpha::Dialog.new(title: "Title")) do |c|
      c.body { "content" }
    end

    assert_selector("modal-dialog[role='dialog']") do
      assert_selector("header") do
        assert_selector("button[aria-label='Close']")
      end
    end
  end
end
