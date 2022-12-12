# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaDropdownTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_without_button
    render_inline(Primer::Alpha::Dropdown.new) { |c| c.menu { "Menu" } }

    refute_selector(".dropdown")
  end

  def test_does_not_render_without_menu
    render_inline(Primer::Alpha::Dropdown.new) { |c| c.button { "Button" } }

    refute_selector(".dropdown")
  end

  def test_renders_dropdown
    render_inline(Primer::Alpha::Dropdown.new) do |c|
      c.button { "Button" }
      c.menu do |m|
        m.item { "Item" }
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
    render_inline(Primer::Alpha::Dropdown.new) do |c|
      c.button { "Button" }
      c.menu(header: "Header") do |m|
        m.item { "Item" }
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
    render_inline(Primer::Alpha::Dropdown.new) do |c|
      c.button { "Button" }
      c.menu do |m|
        m.item { "Item" }
        m.item(divider: true)
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
    render_inline(Primer::Alpha::Dropdown.new) do |c|
      c.button { "Button" }
      c.menu(direction: :s) do |m|
        m.item { "Item" }
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
    render_inline(Primer::Alpha::Dropdown.new(with_caret: true)) do |c|
      c.button { "Button" }
      c.menu do |m|
        m.item { "Item" }
      end
    end

    assert_selector("details.dropdown") do
      assert_selector("summary.btn") do
        assert_selector(".octicon.octicon-triangle-down")
      end
    end
  end
end
