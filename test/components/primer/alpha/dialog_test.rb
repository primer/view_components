# frozen_string_literal: true

require "test_helper"

class PrimerAlphaDialogTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_title_and_body
    render_inline(Primer::Alpha::Dialog.new(title: "title")) do |c|
      c.body { "Hello" }
    end

    assert_selector("modal-dialog[role='dialog']") do
      assert_selector("h1", text: "Title")
      assert_selector(".Overlay-body", text: "Hello")
    end
  end

  def test_raises_on_missing_title
    error = assert_raises(ArgumentError) do
      render_inline(Primer::Alpha::Dialog.new)
    end

    assert_includes(error.message, "missing keyword:")
    assert_includes(error.message, "title")
  end

  def test_renders_provided_id
    render_inline(Primer::Alpha::Dialog.new(title: "Title", id: "my-id")) do |c|
      c.body { "content" }
    end

    assert_selector("modal-dialog[id='my-id']")
  end

  def test_renders_random_id
    render_inline(Primer::Alpha::Dialog.new(title: "Title")) do |c|
      c.body { "content" }
    end

    assert_selector("modal-dialog[id^='dialog_']")
  end

  def test_renders_subtitle_with_describedby
    render_inline(Primer::Alpha::Dialog.new(title: "Title", id: "my-dialog", subtitle: "Subtitle")) do |c|
      c.body { "content" }
    end

    assert_selector("modal-dialog[id='my-dialog'][aria-describedby='my-dialog-subtitle']") do
      assert_selector("h2[id='my-dialog-subtitle']", text: "Subtitle")
    end
  end

  def test_renders_footer_with_divider_by_default
    render_inline(Primer::Alpha::Dialog.new(title: "Title", id: "my-dialog", subtitle: "Subtitle")) do |c|
      c.body { "content" }
      c.footer { "footer" }
    end

    assert_selector("modal-dialog") do
      assert_selector(".Overlay-footer.Overlay-footer--divided", text: "footer")
    end
  end

  def test_renders_footer_without_divider_if_hide_divider
    render_inline(Primer::Alpha::Dialog.new(title: "Title", id: "my-dialog", subtitle: "Subtitle")) do |c|
      c.body { "content" }
      c.footer(hide_divider: true) { "footer" }
    end

    assert_selector("modal-dialog") do
      assert_selector(".Overlay-footer:not(.Overlay-footer--divided)", text: "footer")
    end
  end
end
