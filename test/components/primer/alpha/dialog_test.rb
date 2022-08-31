# frozen_string_literal: true

require "test_helper"

class PrimerAlphaDialogTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_title_and_body
    render_inline(Primer::Alpha::Dialog.new(title: "Title")) do |c|
      c.with_body { "Hello" }
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
      c.with_body { "content" }
    end

    assert_selector("modal-dialog[id='my-id']")
  end

  def test_renders_random_id
    render_inline(Primer::Alpha::Dialog.new(title: "Title")) do |c|
      c.with_body { "content" }
    end

    assert_selector("modal-dialog[id^='dialog-']")
  end

  def test_renders_subtitle_with_describedby
    render_inline(Primer::Alpha::Dialog.new(title: "Title", id: "my-dialog", subtitle: "Subtitle")) do |c|
      c.with_body { "content" }
    end

    assert_selector("modal-dialog[id='my-dialog'][aria-describedby='my-dialog-description']") do
      assert_selector("h2[id='my-dialog-description']", text: "Subtitle")
    end
  end

  def test_renders_footer_without_divider_by_default
    render_inline(Primer::Alpha::Dialog.new(title: "Title", id: "my-dialog", subtitle: "Subtitle")) do |c|
      c.with_body { "content" }
      c.with_footer { "footer" }
    end

    assert_selector("modal-dialog") do
      assert_selector(".Overlay-footer:not(.Overlay-footer--divided)")
    end
  end

  def test_renders_footer_with_divider_if_show_divider_is_true
    render_inline(Primer::Alpha::Dialog.new(title: "Title", id: "my-dialog", subtitle: "Subtitle")) do |c|
      c.with_body { "content" }
      c.with_footer(show_divider: true) { "footer" }
    end

    assert_selector("modal-dialog") do
      assert_selector(".Overlay-footer.Overlay-footer--divided")
    end
  end
end
