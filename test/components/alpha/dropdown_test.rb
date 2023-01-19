# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaDropdownTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_without_button
    render_inline(Primer::Alpha::Dropdown.new) { |component| component.with_menu { "Menu" } }

    refute_selector(".dropdown")
  end

  def test_does_not_render_without_menu
    render_inline(Primer::Alpha::Dropdown.new) { |component| component.with_button { "Button" } }

    refute_selector(".dropdown")
  end

  def test_renders_dropdown
    render_inline(Primer::Alpha::Dropdown.new) do |component|
      component.with_button { "Button" }
      component.with_menu do |menu|
        menu.with_item { "Item" }
      end
    end

    assert_selector("details.dropdown") do
      assert_selector("summary.btn", text: "Button")
      assert_selector("details-menu.dropdown-menu", visible: false) do
        assert_selector(".dropdown-item", text: "Item", visible: false)
      end
    end
  end

  def test_renders_dropdown_with_header
    render_inline(Primer::Alpha::Dropdown.new) do |component|
      component.with_button { "Button" }
      component.with_menu(header: "Header") do |menu|
        menu.with_item { "Item" }
      end
    end

    assert_selector("details.dropdown") do
      assert_selector("summary.btn", text: "Button")
      assert_selector("details-menu.dropdown-menu", visible: false) do
        assert_selector(".dropdown-header", text: "Header", visible: false)
        assert_selector(".dropdown-item", text: "Item", visible: false)
      end
    end
  end

  def test_renders_dropdown_with_divider
    render_inline(Primer::Alpha::Dropdown.new) do |component|
      component.with_button { "Button" }
      component.with_menu do |menu|
        menu.with_item { "Item" }
        menu.with_item(divider: true)
      end
    end

    assert_selector("details.dropdown") do
      assert_selector("summary.btn", text: "Button")
      assert_selector("details-menu.dropdown-menu", visible: false) do
        assert_selector(".dropdown-item", text: "Item", visible: false)
        assert_selector(".dropdown-divider", visible: false)
      end
    end
  end

  def test_renders_dropdown_with_direction
    render_inline(Primer::Alpha::Dropdown.new) do |component|
      component.with_button { "Button" }
      component.with_menu(direction: :s) do |menu|
        menu.with_item { "Item" }
      end
    end

    assert_selector("details.dropdown") do
      assert_selector("summary.btn", text: "Button")
      assert_selector("details-menu.dropdown-menu.dropdown-menu-s", visible: false) do
        assert_selector(".dropdown-item", text: "Item", visible: false)
      end
    end
  end

  def test_renders_caret
    render_inline(Primer::Alpha::Dropdown.new(with_caret: true)) do |component|
      component.with_button { "Button" }
      component.with_menu do |menu|
        menu.with_item { "Item" }
      end
    end

    assert_selector("details.dropdown") do
      assert_selector("summary.btn") do
        assert_selector(".octicon.octicon-triangle-down")
      end
    end
  end
end
