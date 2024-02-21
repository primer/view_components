# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectPageHeaderTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_if_no_title_provided
    render_inline(Primer::OpenProject::PageHeader.new)

    refute_component_rendered
  end

  def test_renders_title
    render_inline(Primer::OpenProject::PageHeader.new) { |header| header.with_title { "Hello" } }

    assert_text("Hello")
    assert_selector(".PageHeader-title")
    assert_selector(".PageHeader-title--medium")
  end

  def test_renders_large_title
    render_inline(Primer::OpenProject::PageHeader.new) { |header| header.with_title(variant: :medium) { "Hello" } }

    assert_text("Hello")
    assert_selector(".PageHeader-title")
    assert_selector(".PageHeader-title--large")
  end

  def test_renders_description
    render_inline(Primer::OpenProject::PageHeader.new) do |header|
      header.with_title { "Hello" }
      header.with_description { "My new description" }
    end

    assert_text("Hello")
    assert_selector(".PageHeader-title")
    assert_text("My new description")
    assert_selector(".PageHeader-description")
  end

  def test_renders_actions
    render_inline(Primer::OpenProject::PageHeader.new) do |header|
      header.with_title { "Hello" }
      header.with_action { "An action" }
    end

    assert_text("Hello")
    assert_selector(".PageHeader-title")
    assert_text("An action")
    assert_selector(".PageHeader-actions")
  end

  def test_renders_leading_action
    render_inline(Primer::OpenProject::PageHeader.new) do |header|
      header.with_title { "Hello" }
      header.with_leading_action(icon: :"arrow-left", href: "/link", 'aria-label': "Back")
    end

    assert_text("Hello")
    assert_selector(".PageHeader-title")
    assert_selector("a.PageHeader-leadingAction[href='/link']")
  end

  def test_renders_breadcrumbs
    breadcrumb_items = [
      { href: "/foo", text: "Foo" },
      "\u003ca href=\"/foo/bar\"\u003eBar\u003c/a\u003e",
      "test"
    ]

    render_inline(Primer::OpenProject::PageHeader.new) do |header|
      header.with_title { "Hello" }
      header.with_breadcrumbs(breadcrumb_items)
    end

    assert_text("Hello")
    assert_selector(".PageHeader-title")
    assert_selector(".PageHeader-breadcrumbs")

    assert_selector("nav[aria-label='Breadcrumb'].PageHeader-breadcrumbs .breadcrumb-item a[href='/foo']")
    assert_selector("nav[aria-label='Breadcrumb'].PageHeader-breadcrumbs .breadcrumb-item a[href='/foo/bar']")
    assert_selector("nav[aria-label='Breadcrumb'].PageHeader-breadcrumbs .breadcrumb-item a[href='#']")
  end

  def test_renders_parent_link
    render_inline(Primer::OpenProject::PageHeader.new) do |header|
      header.with_title { "Hello" }
      header.with_parent_link(href: "test") { "Parent link" }
    end

    assert_text("Hello")
    assert_selector(".PageHeader-title")
    assert_selector(".PageHeader-parentLink")
  end

  def test_renders_context_bar_actions
    render_inline(Primer::OpenProject::PageHeader.new) do |header|
      header.with_title { "Hello" }
      header.with_context_bar_action { "An context bar action" }
    end

    assert_text("Hello")
    assert_selector(".PageHeader-title")
    assert_selector(".PageHeader-contextBarActions")
  end
end
