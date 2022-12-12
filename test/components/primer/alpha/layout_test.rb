# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaLayoutTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_doesnt_render_without_both_slots
    render_inline(Primer::Alpha::Layout.new)
    refute_component_rendered

    render_inline(Primer::Alpha::Layout.new) { |component| component.with_main { "Main" } }
    refute_component_rendered

    render_inline(Primer::Alpha::Layout.new) { |component| component.with_sidebar { "Sidebar" } }
    refute_component_rendered
  end

  def test_renders_layout
    render_inline(Primer::Alpha::Layout.new) do |component|
      component.with_main { "Main" }
      component.with_sidebar { "Sidebar" }
    end

    assert_selector("div.Layout.Layout--sidebarPosition-start") do
      assert_selector("div.Layout-main", text: "Main")
      assert_selector("div.Layout-sidebar", text: "Sidebar")
    end
  end

  def test_main_width
    Primer::Alpha::Layout::Main::WIDTH_OPTIONS.each do |width|
      render_inline(Primer::Alpha::Layout.new) do |component|
        component.with_main(width: width) { "Main" }
        component.with_sidebar { "Sidebar" }
      end

      assert_selector("div.Layout.Layout--sidebarPosition-start") do
        assert_selector("div.Layout-main") do
          if width == :full
            assert_text("Main")
          else
            assert_selector("div.Layout-main-centered-#{width}") do
              assert_selector("div.container-#{width}", text: "Main")
            end
          end
        end
        assert_selector("div.Layout-sidebar", text: "Sidebar")
      end
    end
  end

  def test_sidebar_col_placement
    render_inline(Primer::Alpha::Layout.new) do |component|
      component.with_main { "Main" }
      component.with_sidebar(col_placement: :end) { "Sidebar" }
    end

    assert_selector("div.Layout.Layout--sidebarPosition-end")
  end

  def test_gutter
    (Primer::Alpha::Layout::GUTTER_OPTIONS - [Primer::Alpha::Layout::GUTTER_DEFAULT]).each do |gutter|
      render_inline(Primer::Alpha::Layout.new(gutter: gutter)) do |component|
        component.with_main { "Main" }
        component.with_sidebar { "Sidebar" }
      end

      gutter_class = Primer::Alpha::Layout::GUTTER_MAPPINGS[gutter]
      assert_selector("div.#{gutter_class}")
    end
  end

  def test_stacking_breakpoint
    (Primer::Alpha::Layout::STACKING_BREAKPOINT_OPTIONS - [Primer::Alpha::Layout::STACKING_BREAKPOINT_DEFAULT]).each do |stacking_breakpoint|
      render_inline(Primer::Alpha::Layout.new(stacking_breakpoint: stacking_breakpoint)) do |component|
        component.with_main { "Main" }
        component.with_sidebar { "Sidebar" }
      end

      breakpoint_class = Primer::Alpha::Layout::STACKING_BREAKPOINT_MAPPINGS[stacking_breakpoint]
      assert_selector("div.Layout#{breakpoint_class.empty? ? '' : ".#{breakpoint_class}"}")
    end
  end

  def test_sidebar_row_placement
    Primer::Alpha::Layout::SIDEBAR_ROW_PLACEMENT_OPTIONS.each do |row_placement|
      render_inline(Primer::Alpha::Layout.new) do |component|
        component.with_main { "Main" }
        component.with_sidebar(row_placement: row_placement) { "Sidebar" }
      end

      assert_selector("div.Layout.Layout--sidebarPosition-flowRow-#{row_placement}")
    end
  end

  def test_sidebar_width
    Primer::Alpha::Layout::SIDEBAR_WIDTH_OPTIONS.each do |width|
      next if width == :default

      render_inline(Primer::Alpha::Layout.new) do |component|
        component.with_main { "Main" }
        component.with_sidebar(width: width) { "Sidebar" }
      end

      assert_selector("div.Layout.Layout--sidebar-#{width}")
    end
  end

  def test_sidebar_first_in_html
    render_inline(Primer::Alpha::Layout.new) do |component|
      component.with_main { "Main" }
      component.with_sidebar { "Sidebar" }
    end

    assert_match(/Layout-sidebar.*Layout-main/m, page.native.serialize)
  end

  def test_main_first_in_html
    render_inline(Primer::Alpha::Layout.new(first_in_source: :main)) do |component|
      component.with_main { "Main" }
      component.with_sidebar { "Sidebar" }
    end

    assert_match(/Layout-main.*Layout-sidebar/m, page.native.serialize)
  end

  def test_renders_main_slot_as_different_elements
    Primer::Alpha::Layout::Main::TAG_OPTIONS.each do |tag|
      render_inline(Primer::Alpha::Layout.new) do |component|
        component.with_main(tag: tag) { "Main" }
        component.with_sidebar { "Sidebar" }
      end

      assert_selector("div.Layout.Layout--sidebarPosition-start") do
        assert_selector("#{tag}.Layout-main", text: "Main")
        assert_selector("div.Layout-sidebar", text: "Sidebar")
      end
    end
  end

  def test_renders_sidebar_slot_as_different_elements
    Primer::Alpha::Layout::Sidebar::TAG_OPTIONS.each do |tag|
      render_inline(Primer::Alpha::Layout.new) do |component|
        component.with_main { "Main" }
        component.with_sidebar(tag: tag) { "Sidebar" }
      end

      assert_selector("div.Layout.Layout--sidebarPosition-start") do
        assert_selector("div.Layout-main", text: "Main")
        assert_selector("#{tag}.Layout-sidebar", text: "Sidebar")
      end
    end
  end
end
