# frozen_string_literal: true

require "components/test_helper"

class PrimerBreadcrumbsTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_if_no_items_provided
    render_inline(Primer::Beta::Breadcrumbs.new)

    refute_component_rendered
  end

  def test_system_argument_restriction
    with_raise_on_invalid_options(true) do
      error = assert_raises(ArgumentError) do
        render_inline(Primer::Beta::Breadcrumbs.new(p: 0)) do |component|
          component.with_item(href: "/") { "Home" }
        end
      end

      assert_includes(error.message, "Padding system arguments are not allowed on Breadcrumbs. Consider using margins instead.")

      error = assert_raises(ArgumentError) do
        render_inline(Primer::Beta::Breadcrumbs.new(font_size: 4)) do |component|
          component.with_item(href: "/") { "Home" }
        end
      end

      assert_includes(error.message, "not support the font_size system argument.")
    end
  end

  def test_renders_single_item
    render_inline(Primer::Beta::Breadcrumbs.new) do |component|
      component.with_item(href: "/") { "Home" }
    end

    assert_selector("nav[aria-label='Breadcrumb'] .breadcrumb-item", text: "Home")
  end

  def test_renders_multiple_items
    render_inline(Primer::Beta::Breadcrumbs.new) do |component|
      component.with_item(href: "/") { "Home" }
      component.with_item(href: "/about") { "About" }
      component.with_item(href: "/about/team") { "Team" }
    end

    assert_selector("nav[aria-label='Breadcrumb'] .breadcrumb-item", count: 3)
  end

  def test_renders_links_when_specified
    render_inline(Primer::Beta::Breadcrumbs.new) do |component|
      component.with_item(href: "/") { "Home" }
      component.with_item(href: "/about") { "About" }
    end

    assert_selector("nav[aria-label='Breadcrumb'] .breadcrumb-item a", count: 2)
    assert_selector("nav[aria-label='Breadcrumb'] .breadcrumb-item a[href='/']")
  end

  def test_automatically_selects_last_item
    render_inline(Primer::Beta::Breadcrumbs.new) do |component|
      component.with_item(href: "/") { "Home" }
      component.with_item(href: "/about") { "About" }
    end

    assert_selector("li.breadcrumb-item-selected a[aria-current='page']", text: "About")
  end

  def test_status
    assert_component_state(Primer::Beta::Breadcrumbs, :beta)
  end
end
