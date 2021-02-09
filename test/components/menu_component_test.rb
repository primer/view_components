# frozen_string_literal: true

require "test_helper"

class PrimerMenuComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_without_items
    render_inline(Primer::MenuComponent.new)

    refute_selector(".menu")
  end

  def test_renders_items
    render_inline(Primer::MenuComponent.new) do |c|
      c.item(selected: true, href: "#url") { "Item 1" }
      c.item(href: "#url") { "Item 2" }
    end

    assert_selector("nav.menu") do
      assert_selector("a.menu-item[href=\"#url\"][aria-current=\"page\"]", text: "Item 1")
      assert_selector("a.menu-item[href=\"#url\"]", text: "Item 2")
    end
  end

  def test_renders_heading
    render_inline(Primer::MenuComponent.new) do |c|
      c.heading { "Heading" }
      c.item(selected: true, href: "#url") { "Item 1" }
      c.item(href: "#url") { "Item 2" }
    end

    assert_selector("nav.menu") do
      assert_selector("span.menu-heading", text: "Heading")
      assert_selector("a.menu-item[href=\"#url\"][aria-current=\"page\"]", text: "Item 1")
      assert_selector("a.menu-item[href=\"#url\"]", text: "Item 2")
    end
  end
end
