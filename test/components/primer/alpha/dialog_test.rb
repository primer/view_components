# frozen_string_literal: true

require "components/test_helper"

module Primer
  module Alpha
    class DialogTest < Minitest::Test
      include Primer::ComponentTestHelpers

      def test_renders_title_and_body
        render_inline(Primer::Alpha::Dialog.new(title: "Title")) do |component|
          component.with_body { "Hello" }
        end

        assert_selector("dialog") do
          assert_selector("h1", text: "Title")
          assert_selector(".Overlay-body", text: "Hello")
        end
      end

      def test_renders_show_button
        render_inline(Primer::Alpha::Dialog.new(title: "Title")) do |component|
          component.with_body { "Hello" }
          component.with_show_button { "Show" }
        end

        assert_selector("[data-show-dialog-id]")
      end

      def test_renders_icon_show_button
        render_preview :playground, params: { icon: :ellipsis }

        assert_selector("button[data-show-dialog-id] svg.octicon.octicon-ellipsis")
      end

      def test_raises_on_missing_title
        error = assert_raises(ArgumentError) do
          render_inline(Primer::Alpha::Dialog.new)
        end

        assert_includes(error.message, "missing keyword:")
        assert_includes(error.message, "title")
      end

      def test_renders_provided_id
        render_inline(Primer::Alpha::Dialog.new(title: "Title", id: "my-id")) do |component|
          component.with_body { "content" }
        end

        assert_selector("dialog[id='my-id']")
      end

      def test_renders_random_id
        render_inline(Primer::Alpha::Dialog.new(title: "Title")) do |component|
          component.with_body { "content" }
        end

        assert_selector("dialog[id^='dialog-']")
      end

      def test_renders_title_and_subtitle_with_describedby
        render_inline(Primer::Alpha::Dialog.new(title: "Title", id: "my-dialog", subtitle: "Subtitle")) do |component|
          component.with_body { "content" }
        end

        assert_selector("dialog[id='my-dialog'][aria-labelledby='my-dialog-title'][aria-describedby='my-dialog-description']") do
          assert_selector("h1[id='my-dialog-title']", text: "Title")
          assert_selector("h2[id='my-dialog-description']", text: "Subtitle")
        end
      end

      def test_renders_header
        render_inline(Primer::Alpha::Dialog.new(title: "Title", id: "my-dialog")) do |component|
          component.with_body { "content" }
          component.with_header { "header" }
        end

        assert_selector("dialog") do
          assert_selector(".Overlay-header", text: "header")
        end
      end

      def test_renders_large_header
        render_inline(Primer::Alpha::Dialog.new(title: "Title", id: "my-dialog")) do |component|
          component.with_body { "content" }
          component.with_header(variant: :large) { "header" }
        end

        assert_selector("dialog") do
          assert_selector(".Overlay-header.Overlay-header--large", text: "header")
        end
      end

      def test_renders_footer_without_divider_by_default
        render_inline(Primer::Alpha::Dialog.new(title: "Title", id: "my-dialog", subtitle: "Subtitle")) do |component|
          component.with_body { "content" }
          component.with_footer { "footer" }
        end

        assert_selector("dialog") do
          assert_selector(".Overlay-footer:not(.Overlay-footer--divided)")
        end
      end

      def test_renders_footer_with_divider_if_show_divider_is_true
        render_inline(Primer::Alpha::Dialog.new(title: "Title", id: "my-dialog", subtitle: "Subtitle")) do |component|
          component.with_body { "content" }
          component.with_footer(show_divider: true) { "footer" }
        end

        assert_selector("dialog") do
          assert_selector(".Overlay-footer.Overlay-footer--divided")
        end
      end
    end
  end
end
