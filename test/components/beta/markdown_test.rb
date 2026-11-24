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

  def test_task_list_labels_are_unique_in_all_theme_copies
    ActionView::Base.any_instance.stubs(:stylesheet_link_tag).returns("")
    ActionView::Base.any_instance.stubs(:vite_typescript_tag).returns("")

    %i[playground default].each do |preview|
      rendered = render_preview(preview, from: Primer::Beta::MarkdownPreview, params: { theme: "all" })
      copies = rendered.css(".preview-wrap")
      groups = rendered.css(".markdown-body [role='group']")
      label_ids = groups.map { |group| group["aria-labelledby"] }
      checkbox_ids = rendered.css(".markdown-body input[type='checkbox']").map { |input| input["id"] }

      assert_equal 7, copies.length
      assert_equal 14, groups.length
      assert_equal label_ids.length, label_ids.uniq.length
      assert_equal checkbox_ids.length, checkbox_ids.uniq.length

      copies.each do |copy|
        copy.css("[role='group']").each do |group|
          label = rendered.at_css("##{group['aria-labelledby']}")

          assert_equal "p", label.name
          assert_equal group.previous_element, label
        end

        copy.css("label[for]").each do |label|
          assert_equal label.previous_element, rendered.at_css("##{label['for']}")
        end
      end
    end
  end
end
