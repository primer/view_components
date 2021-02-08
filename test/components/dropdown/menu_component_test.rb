# frozen_string_literal: true

require "test_helper"

class PrimerDropdownMenuComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_dropdown_component_renders_dark_scheme
    render_inline(Primer::Dropdown::MenuComponent.new(scheme: :dark)) { "Body" }

    assert_selector("details-menu.dropdown-menu.dropdown-menu-dark")
  end

  def test_dropdown_direction_renders
    render_inline(Primer::Dropdown::MenuComponent.new(direction: :w)) { "Body" }

    assert_selector("details-menu.dropdown-menu.dropdown-menu-w")
  end

  def test_falls_back_to_defaults_when_invalid_options_are_passed
    without_fetch_or_fallback_raises do
      render_inline(Primer::Dropdown::MenuComponent.new(direction: :circle, scheme: :orange)) { "Body" }
    end

    assert_selector("details-menu.dropdown-menu")
  end

  def test_dropdown_header_renders
    render_inline(Primer::Dropdown::MenuComponent.new(header: "Header")) { "Body" }

    assert_selector(".dropdown-header")
  end

  def test_renders_items
    render_inline(Primer::Dropdown::MenuComponent.new(header: "Header")) do |c|
      c.item { "Item 1" }
      c.item { "Item 2" }
    end

    assert_selector(".dropdown-item", text: "Item 1")
    assert_selector(".dropdown-item", text: "Item 2")
  end

  def test_renders_dividers
    render_inline(Primer::Dropdown::MenuComponent.new(header: "Header")) do |c|
      c.item(divider: true)
    end

    assert_selector(".dropdown-divider")
  end
end
