# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaMenuTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_without_items
    render_inline(Primer::Alpha::Menu.new)

    refute_selector(".menu")
  end

  def test_renders_items
    render_inline(Primer::Alpha::Menu.new) do |c|
      c.item(selected: true, href: "#url") { "Item 1" }
      c.item(href: "#url") { "Item 2" }
    end

    assert_selector("nav.menu") do
      assert_selector("a.menu-item[href=\"#url\"][aria-current=\"page\"]", text: "Item 1")
      assert_selector("a.menu-item[href=\"#url\"]", text: "Item 2")
    end
  end

  def test_renders_heading
    render_inline(Primer::Alpha::Menu.new) do |c|
      c.heading(tag: :h3) { "Heading" }
      c.item(selected: true, href: "#url") { "Item 1" }
      c.item(href: "#url") { "Item 2" }
    end

    assert_selector("nav.menu") do
      assert_selector("h3.menu-heading", text: "Heading")
    end
  end

  def test_falls_back_to_h2_when_heading_tag_isnt_valid
    without_fetch_or_fallback_raises do
      render_inline(Primer::Alpha::Menu.new) do |c|
        c.heading(tag: :div) { "Heading" }
        c.item(selected: true, href: "#url") { "Item 1" }
        c.item(href: "#url") { "Item 2" }
      end

      assert_selector("nav.menu") do
        assert_selector("h2.menu-heading", text: "Heading")
      end
    end
  end
end
