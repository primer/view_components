# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectPageHeaderTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_raises_if_no_title_provided
    err = assert_raises ArgumentError do
      render_inline(Primer::OpenProject::PageHeader.new)
    end

    assert_equal("PageHeader needs a title and a breadcrumb. Please use the `with_title` and `with_breadcrumbs` slot", err.message)
  end

  def test_raises_if_no_breadcrumb_provided
    err = assert_raises ArgumentError do
      render_inline(Primer::OpenProject::PageHeader.new) do |header|
        header.with_title { "Hello" }
      end

    end

    assert_equal("PageHeader needs a title and a breadcrumb. Please use the `with_title` and `with_breadcrumbs` slot", err.message)
  end

  def test_renders_title
    render_inline(Primer::OpenProject::PageHeader.new) do |header|
      header.with_title { "Hello" }
      header.with_breadcrumbs(breadcrumb_elements)
    end

    assert_text("Hello")
    assert_selector(".PageHeader-title")
    assert_selector(".PageHeader-title--medium")
  end

  def test_renders_large_title
    render_inline(Primer::OpenProject::PageHeader.new)  do |header|
      header.with_title(variant: :large) { "Hello" }
      header.with_breadcrumbs(breadcrumb_elements)
    end

    assert_text("Hello")
    assert_selector(".PageHeader-title")
    assert_selector(".PageHeader-title--large")
  end

  def test_renders_description
    render_inline(Primer::OpenProject::PageHeader.new) do |header|
      header.with_title { "Hello" }
      header.with_breadcrumbs(breadcrumb_elements)
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
      header.with_breadcrumbs(breadcrumb_elements)
      header.with_action_button(mobile_icon: "pencil", mobile_label: "Action") { "An action" }
      header.with_action_text { "An additional hint" }
      header.with_action_icon_button(icon: "trash", mobile_icon: "trash", label: "Delete") { "Delete" }
      header.with_action_link(mobile_icon: "link", mobile_label: "Link to", href: "https://community.openproject.com") { "Link to.." }
    end

    # Renders the actions
    assert_text("Hello")
    assert_selector(".PageHeader-title")
    assert_selector(".PageHeader-actions")
    assert_text("An action")
    assert_text("An additional hint")

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

    # The text is hidden on mobile
    assert_selector("span.d-none.d-sm-flex")
  end

  def test_renders_a_menu_as_action
    render_inline(Primer::OpenProject::PageHeader.new) do |header|
      header.with_title { "Hello" }
      header.with_breadcrumbs(breadcrumb_elements)

      header.with_action_link(mobile_icon: "link", mobile_label: "Link to", href: "https://community.openproject.com") { "Link to.." }
      header.with_action_menu(menu_arguments: { anchor_align: :end }, button_arguments: { icon: "op-kebab-vertical", "aria-label": "Some actions" })  do |menu, button|
        menu.with_item(label: "Subitem 1") do |item|
          item.with_leading_visual_icon(icon: :paste)
        end
      end
    end

    assert_selector(".PageHeader-actions .ActionListItem-label") do
      assert_text("Subitem 1")
    end
    assert_selector(".PageHeader-contextBar .ActionListItem-label") do
      assert_text("Link to")
    end
    assert_selector(".PageHeader-contextBar .ActionListItem-label") do
      assert_text("Subitem 1")
    end
  end

  def test_renders_a_dialog_as_action
    render_inline(Primer::OpenProject::PageHeader.new) do |header|
      header.with_title { "Hello" }
      header.with_breadcrumbs(breadcrumb_elements)
      header.with_action_dialog(mobile_icon: "alert",
                                mobile_label: "Open a dialog",
                                dialog_arguments: { id: "my-dialog", title: "A great dialog" },
                                button_arguments: { icon: "alert", "aria-label": "Some dialog" })  do |dialog|
        dialog.with_body { "Hello" }
      end
    end

    assert_selector(".PageHeader-actions #dialog-show-my-dialog")
    assert_selector("dialog#my-dialog")
  end

  def test_renders_a_zen_mode_button_as_action
    render_inline(Primer::OpenProject::PageHeader.new) do |header|
      header.with_title { "Hello" }
      header.with_breadcrumbs(breadcrumb_elements)
      header.with_action_zen_mode_button
    end

    assert_selector(".PageHeader-actions zen-mode-button")
  end

  def test_renders_single_action
    render_inline(Primer::OpenProject::PageHeader.new) do |header|
      header.with_title { "Hello" }
      header.with_breadcrumbs(breadcrumb_elements)
      header.with_action_button(mobile_icon: "pencil", mobile_label: "Action") { "An action" }
    end

    assert_text("Hello")
    assert_selector(".PageHeader-title")
    assert_text("An action")
    assert_selector(".PageHeader-actions")
    assert_selector(".PageHeader-contextBar .Button--small.d-flex.d-sm-none")
  end

  def test_renders_leading_action
    render_inline(Primer::OpenProject::PageHeader.new) do |header|
      header.with_title { "Hello" }
      header.with_breadcrumbs(breadcrumb_elements)
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
    assert_selector("nav[aria-label='Breadcrumb'].PageHeader-breadcrumbs .breadcrumb-item.text-bold a[href='#']")
  end

  def test_renders_non_bold_breadcrumbs
    breadcrumb_items = [
      { href: "/foo", text: "Foo" },
      "\u003ca href=\"/foo/bar\"\u003eBar\u003c/a\u003e",
      { href: "#", text: "test" },
      "test"
    ]

    render_inline(Primer::OpenProject::PageHeader.new) do |header|
      header.with_title { "Hello" }
      header.with_breadcrumbs(breadcrumb_items, selected_item_font_weight: :normal)
    end

    assert_text("Hello")
    assert_selector(".PageHeader-title")
    assert_selector(".PageHeader-breadcrumbs")
    assert_selector(".PageHeader-parentLink")

    assert_selector("nav[aria-label='Breadcrumb'].PageHeader-breadcrumbs .breadcrumb-item a[href='/foo']")
    assert_selector("nav[aria-label='Breadcrumb'].PageHeader-breadcrumbs .breadcrumb-item a[href='/foo/bar']")
    assert_selector("nav[aria-label='Breadcrumb'].PageHeader-breadcrumbs .breadcrumb-item:not(.text-bold) a[href='#']")
  end

  private

  def breadcrumb_elements
    [{ href: "/foo", text: "Foo" }, { href: "/bar", text: "Bar" }, "Baz"]
  end
end
