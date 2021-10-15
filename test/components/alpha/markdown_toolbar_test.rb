# frozen_string_literal: true

require "test_helper"

class PrimerAlphaMarkdownToolbarTest < Minitest::Test
  include Primer::ComponentTestHelpers

  fixtures do
    @user = create(:user)
  end

  test "render" do
    as @user
    component = Comments::MarkdownToolbarComponent.new(textarea_id: "an_id")
    render_inline(component, allowed_queries: 0)

    assert_selector "markdown-toolbar[for='an_id']"

    # Doesn't render
    refute_selector "[data-test-selector='github-specific-md-buttons']"
    refute_selector "md-ref[aria-label='Reference an issue or pull request']"

    # Reponsive and show_suggested_changes_button?
    # Doesn't render
    refute_selector ".js-suggestion-button-placeholder"
    refute_selector "[data-test-selector='suggestion-button']"
    refute_selector ".js-suggested-change-onboarding-notice"

    # Responsive Items
    refute_selector ".js-markdown-link-button"
    refute_selector ".js-markdown-link-dialog"

    # Reponsive and attachments_enabled?
    # Doesn't render
    refute_selector "[data-test-selector='file-chooser-toolbar-item']"

    # Shown if hide_saved_replies is false (default)
    # Doesn't render
    refute_selector ".js-saved-reply-container"
    refute_selector "details-menu[src='#{controller.saved_replies_path(context: "none")}']", visible: false

    # Toolbar items
    %w( md-quote md-code md-link ).each do |toolbar_item|
      assert_selector toolbar_item, count: 1
    end
    # Doesn't render
    refute_selector "md-mention"
    refute_selector "md-ref"

    # Toolbar items rendered twice if responsive
    %w( md-header md-bold md-italic md-unordered-list md-ordered-list md-task-list ).each do |toolbar_item|
      assert_selector toolbar_item, count: 1
    end
  end

  test "render with hint" do
    as @user
    component = Comments::MarkdownToolbarComponent.new(textarea_id: "an_id")
    render_inline(component, allowed_queries: 1)

    assert_selector "md-header[aria-label='Add header text']"
    assert_selector "md-bold[aria-label='Add bold text <ctrl+b>']"
    assert_selector "md-italic[aria-label='Add italic text <ctrl+i>']"
    assert_selector "md-quote[aria-label='Insert a quote <ctrl+shift+.>']"
    assert_selector "md-link[aria-label='Add a link <ctrl+k>']"
    assert_selector "md-code[aria-label='Insert code <ctrl+e>']"
    assert_selector "md-unordered-list[aria-label='Add a bulleted list <ctrl+shift+8>']"
    assert_selector "md-ordered-list[aria-label='Add a numbered list <ctrl+shift+7>']"
    assert_selector "md-task-list[aria-label='Add a task list <ctrl+shift+l>']"
  end

  test "render with responsive if user disabled shortcuts" do
    as @user
    render_inline(
      Comments::MarkdownToolbarComponent.new(textarea_id: "an_id", responsive: true),
      allowed_queries: 0
    )
    assert_selector "markdown-toolbar[for='an_id']"

    # Doesn't render
    refute_selector "[data-test-selector='github-specific-md-buttons']"
    refute_selector "md-ref[aria-label='Reference an issue or pull request']"

    # Reponsive and show_suggested_changes_button?
    # Doesn't render
    refute_selector ".js-suggestion-button-placeholder"
    refute_selector "[data-test-selector='suggestion-button']"
    refute_selector ".js-suggested-change-onboarding-notice"

    # Responsive Items
    assert_selector ".js-markdown-link-button"
    assert_selector ".js-markdown-link-dialog", visible: false

    # Reponsive and attachments_enabled?
    # Doesn't render
    refute_selector "[data-test-selector='file-chooser-toolbar-item']"

    # Shown if hide_saved_replies is false (default)
    # Doesn't render
    refute_selector ".js-saved-reply-container"
    refute_selector "details-menu[src='#{controller.saved_replies_path(context: "none")}']", visible: false

    # Toolbar items
    %w( md-quote md-code md-link ).each do |toolbar_item|
      assert_selector toolbar_item, count: 1
    end
    # Doesn't render
    refute_selector "md-mention"
    refute_selector "md-ref"

    # Toolbar items rendered twice if responsive
    %w( md-header md-bold md-italic md-unordered-list md-ordered-list md-task-list ).each do |toolbar_item|
      assert_selector toolbar_item, count: 2
    end
  end
end
