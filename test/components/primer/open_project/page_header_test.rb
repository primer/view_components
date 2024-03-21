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
    render_inline(Primer::OpenProject::PageHeader.new) { |header| header.with_title(variant: :large) { "Hello" } }

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
      header.with_action_button(mobile_icon: "pencil", mobile_label: "Action") { "An action" }
      header.with_action_text { "An additional hint" }
      header.with_action_icon_button(icon: "trash", mobile_icon: "trash", label: "Delete") { "Delete" }
      header.with_action_link(mobile_icon: "link", mobile_label: "Link to", href: "https://community.openproject.com") { "Link to.." }
      header.with_action_menu(menu_arguments: { anchor_align: :end }, button_arguments: { icon: "op-kebab-vertical", "aria-label": "Some actions" })  do |menu, button|
        menu.with_item(label: "Subitem 1") do |item|
          item.with_leading_visual_icon(icon: :paste)
        end
      end
    end

    # Renders the actions
    assert_text("Hello")
    assert_selector(".PageHeader-title")
    assert_selector(".PageHeader-actions")
    assert_text("An action")
    assert_text("An additional hint")
    assert_selector(".PageHeader-actions .ActionListItem-label") do
      assert_text("Subitem 1")
    end

    # The mobile variant of the actions is already rendered, but hidden
    assert_selector(".PageHeader-contextBar")
    assert_selector("action-menu.d-flex.d-sm-none")
    assert_selector(".PageHeader-contextBar .ActionListItem-label") do
      assert_text("Action")
    end
    assert_selector(".PageHeader-contextBar .ActionListItem-label") do
      assert_text("Delete")
    end
    assert_selector(".PageHeader-contextBar .ActionListItem-label") do
      assert_text("Link to")
    end
    assert_selector(".PageHeader-contextBar .ActionListItem-label") do
      assert_text("Subitem 1")
    end

    # The text is hidden on mobile
    assert_selector("span.d-none.d-sm-flex")
  end

  def test_renders_actions_without_mobile_menu
    render_inline(Primer::OpenProject::PageHeader.new(show_mobile_menu: false)) do |header|
      header.with_title { "Hello" }
      header.with_action_button(mobile_icon: "pencil", mobile_label: "Action") { "An action" }
    end

    assert_text("Hello")
    assert_selector(".PageHeader-title")
    assert_text("An action")
    assert_selector(".PageHeader-actions")

    # There is no mobile menu
    assert_selector(".PageHeader-contextBar")
    assert_no_selector("action-menu")
    assert_selector(".PageHeader-actions .Button.d-flex")
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
      { href: "#", text: "test" },
      "test"
    ]

    render_inline(Primer::OpenProject::PageHeader.new) do |header|
      header.with_title { "Hello" }
      header.with_breadcrumbs(breadcrumb_items)
    end

    assert_text("Hello")
    assert_selector(".PageHeader-title")
    assert_selector(".PageHeader-breadcrumbs")
    assert_selector(".PageHeader-parentLink")

    assert_selector("nav[aria-label='Breadcrumb'].PageHeader-breadcrumbs .breadcrumb-item a[href='/foo']")
    assert_selector("nav[aria-label='Breadcrumb'].PageHeader-breadcrumbs .breadcrumb-item a[href='/foo/bar']")
    assert_selector("nav[aria-label='Breadcrumb'].PageHeader-breadcrumbs .breadcrumb-item a[href='#']")
  end
end
