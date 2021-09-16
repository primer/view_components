# frozen_string_literal: true

require "test_helper"

class PrimerBreadcrumbsTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_if_no_items_provided
    render_inline(Primer::Beta::Breadcrumbs.new)

    refute_component_rendered
  end

  def test_renders_single_item
    render_inline(Primer::Beta::Breadcrumbs.new) do |component|
      component.item(href: "/") { "Home" }
    end

    assert_selector("nav[aria-label='Breadcrumb'] .breadcrumb-item", text: "Home")
  end

  def test_renders_multiple_items
    render_inline(Primer::Beta::Breadcrumbs.new) do |component|
      component.item(href: "/") { "Home" }
      component.item(href: "/about") { "About" }
      component.item(href: "/about/team") { "Team" }
    end

    assert_selector("nav[aria-label='Breadcrumb'] .breadcrumb-item", count: 3)
  end

  def test_renders_links_when_specified
    render_inline(Primer::Beta::Breadcrumbs.new) do |component|
      component.item(href: "/") { "Home" }
      component.item(href: "/about") { "About" }
    end

    assert_selector("nav[aria-label='Breadcrumb'] .breadcrumb-item a", count: 2)
    assert_selector("nav[aria-label='Breadcrumb'] .breadcrumb-item a[href='/']")
  end

  def test_automatically_selects_last_item
    render_inline(Primer::Beta::Breadcrumbs.new) do |component|
      component.item(href: "/") { "Home" }
      component.item(href: "/about") { "About" }
    end

    assert_selector("li.breadcrumb-item-selected a[aria-current='page']", text: "About")
  end

  def test_status
    assert_component_state(Primer::Beta::Breadcrumbs, :beta)
  end
end
