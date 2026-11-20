# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaMarkdownTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_with_content
    render_inline(Primer::Beta::Markdown.new) { "Content" }

    assert_selector(".markdown-body", text: "Content")
  end

  def test_renders_with_article
    render_inline(Primer::Beta::Markdown.new(tag: :article)) { "Content" }

    assert_selector("article.markdown-body", text: "Content")
  end

  def test_renders_with_td
    render_inline(Primer::Beta::Markdown.new(tag: :td)) { "Content" }

    assert_selector("td.markdown-body", text: "Content")
  end

  def test_falls_back_when_tag_isnt_valid
    without_fetch_or_fallback_raises do
      render_inline(Primer::Beta::Markdown.new(tag: :h3)) { "Content" }
      assert_selector("div.markdown-body")
    end
  end

  def test_renders_named_unordered_task_lists
    %i[playground default].each do |preview|
      preview_args = Primer::Beta::MarkdownPreview.render_args(preview)
      render_inline(preview_args[:component], **preview_args[:args], &preview_args[:block])

      assert_selector("p#unordered-task-list-label", exact_text: "And an unordered task list:")
      assert_selector("[role='group'][aria-labelledby='unordered-task-list-label']") do |group|
        group.assert_selector("ul:not([role]) > li:not([role])", count: 3)
        group.assert_selector("input[type='checkbox']", count: 3)
        group.assert_selector(:checkbox, "Create a sample markdown document", exact: true, checked: true)
        group.assert_selector(:checkbox, "Add task lists to it", exact: true, checked: false)
        group.assert_selector(:checkbox, "Take a vacation", exact: true, checked: false)
      end
    end
  end

  def test_renders_named_mixed_task_lists
    %i[playground default].each do |preview|
      preview_args = Primer::Beta::MarkdownPreview.render_args(preview)
      render_inline(preview_args[:component], **preview_args[:args], &preview_args[:block])

      assert_selector("p#mixed-task-list-label", exact_text: 'And a "mixed" task list:')
      assert_selector("[role='group'][aria-labelledby='mixed-task-list-label']") do |group|
        group.assert_selector("ul:not([role]) > li:not([role])", count: 3)
        group.assert_selector("input[type='checkbox']", count: 2)
        group.assert_selector(:checkbox, "Steal underpants", exact: true, checked: false)
        group.assert_selector(:checkbox, "Profit!", exact: true, checked: false)
        group.assert_selector("li", exact_text: "?") do |item|
          item.assert_no_selector("input")
        end
      end
    end
  end
end
