# frozen_string_literal: true

require "components/test_helper"

class Primer::Alpha::Dropdown::MenuTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_dropdown_component_renders_dark_scheme
    render_inline(Primer::Alpha::Dropdown::Menu.new(scheme: :dark)) { "Body" }

    assert_selector("details-menu.dropdown-menu.dropdown-menu-dark")
  end

  def test_dropdown_direction_renders
    render_inline(Primer::Alpha::Dropdown::Menu.new(direction: :w)) { "Body" }

    assert_selector("details-menu.dropdown-menu.dropdown-menu-w")
  end

  def test_falls_back_to_defaults_when_invalid_options_are_passed
    without_fetch_or_fallback_raises do
      render_inline(Primer::Alpha::Dropdown::Menu.new(direction: :circle, scheme: :orange)) { "Body" }
    end

    assert_selector("details-menu.dropdown-menu")
  end

  def test_dropdown_header_renders
    render_inline(Primer::Alpha::Dropdown::Menu.new(header: "Header")) { "Body" }

    assert_selector(".dropdown-header")
  end

  def test_renders_items
    render_inline(Primer::Alpha::Dropdown::Menu.new(header: "Header")) do |c|
      c.item { "Item 1" }
      c.item { "Item 2" }
    end

    assert_selector(".dropdown-item[role='menuitem']", text: "Item 1")
    assert_selector(".dropdown-item[role='menuitem']", text: "Item 2")
  end

  def test_renders_items_as_buttons
    render_inline(Primer::Alpha::Dropdown::Menu.new(header: "Header")) do |c|
      c.item(tag: :button) { "Item 1" }
      c.item(tag: :button) { "Item 2" }
    end

    assert_selector("button.dropdown-item[role='menuitem']", text: "Item 1")
    assert_selector("button.dropdown-item[role='menuitem']", text: "Item 2")
  end

  def test_renders_dividers
    render_inline(Primer::Alpha::Dropdown::Menu.new(header: "Header")) do |c|
      c.item(divider: true)
    end

    assert_selector(".dropdown-divider[role='separator']")
  end

  def test_renders_as_list
    render_inline(Primer::Alpha::Dropdown::Menu.new(as: :list, header: "Header")) do |c|
      c.item { "Item 1" }
      c.item(divider: true)
      c.item { "Item 2" }
    end

    assert_selector("details-menu.dropdown-menu") do
      assert_selector("ul") do
        assert_selector("li") do
          assert_selector(".dropdown-item[role='menuitem']", text: "Item 1")
        end
        assert_selector("li.dropdown-divider[role='separator']")
        assert_selector("li") do
          assert_selector(".dropdown-item[role='menuitem']", text: "Item 2")
        end
      end
    end
  end
end
