# frozen_string_literal: true

require "test_helper"

class PrimerBreadcrumbComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_if_no_items_provided
    render_inline(Primer::BreadcrumbComponent.new)

    refute_component_rendered
  end

  def test_renders_single_item
    render_inline(Primer::BreadcrumbComponent.new) do |component|
      component.item { "Home" }
    end

    assert_selector("nav[aria-label='Breadcrumb'] .breadcrumb-item", text: "Home")
  end

  def test_renders_multiple_items
    render_inline(Primer::BreadcrumbComponent.new) do |component|
      component.item { "Home" }
      component.item { "About" }
      component.item { "Team" }
    end

    assert_selector("nav[aria-label='Breadcrumb'] .breadcrumb-item", count: 3)
  end

  def test_renders_links_when_specified
    render_inline(Primer::BreadcrumbComponent.new) do |component|
      component.item(href: "/") { "Home" }
      component.item { "About" }
    end

    assert_selector("nav[aria-label='Breadcrumb'] .breadcrumb-item a", count: 1)
    assert_selector("nav[aria-label='Breadcrumb'] .breadcrumb-item a[href='/']")
  end

  def test_does_not_render_a_link_when_item_is_selected
    render_inline(Primer::BreadcrumbComponent.new) do |component|
      component.item(href: "/", selected: true) { "Home" }
      component.item { "About" }
    end

    refute_selector("nav[aria-label='Breadcrumb'] .breadcrumb-item a")
  end

  def test_status
    assert_component_state(Primer::BreadcrumbComponent, :beta)
  end
end
