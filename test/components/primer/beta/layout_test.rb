# frozen_string_literal: true

require "test_helper"

class PrimerBetaLayoutTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_doesnt_render_without_both_slots
    render_inline(Primer::Beta::Layout.new)
    refute_component_rendered

    render_inline(Primer::Beta::Layout.new) { |c| c.main { "Main" } }
    refute_component_rendered

    render_inline(Primer::Beta::Layout.new) { |c| c.pane { "Pane" } }
    refute_component_rendered
  end

  def test_renders_layout
    render_inline(Primer::Beta::Layout.new) do |c|
      c.main { "Main" }
      c.pane { "Pane" }
    end

    assert_selector("div.LayoutBeta") do
      assert_selector("div.LayoutBeta-content", text: "Main")
      assert_selector("div.LayoutBeta-pane", text: "Pane")
    end
  end

  def test_wrapper_sizing
    Primer::Beta::Layout::WRAPPER_SIZING_OPTIONS.each do |size|
      render_inline(Primer::Beta::Layout.new(wrapper_sizing: size)) do |c|
        c.main { "Main" }
        c.pane { "Pane" }
      end

      assert_selector("div.LayoutBeta") do
        if size == :fluid
          assert_selector("div.LayoutBeta-regions") do
            assert_selector("div.LayoutBeta-content", text: "Main")
            assert_selector("div.LayoutBeta-pane", text: "Pane")
          end
        else
          assert_selector("div.LayoutBeta-regions.container-#{size}") do
            assert_selector("div.LayoutBeta-content", text: "Main")
            assert_selector("div.LayoutBeta-pane", text: "Pane")
          end
        end
      end
    end
  end

  def test_outer_spacing
    Primer::Beta::Layout::OUTER_SPACING_OPTIONS.each do |size|
      render_inline(Primer::Beta::Layout.new(outer_spacing: size)) do |c|
        c.main { "Main" }
        c.pane { "Pane" }
      end

      assert_selector("div.LayoutBeta") do
        if size == :none
          assert_selector("div.LayoutBeta") do
            assert_selector("div.LayoutBeta-content", text: "Main")
            assert_selector("div.LayoutBeta-pane", text: "Pane")
          end
        else
          assert_selector("div.LayoutBeta.LayoutBeta--outer-spacing-#{size}") do
            assert_selector("div.LayoutBeta-content", text: "Main")
            assert_selector("div.LayoutBeta-pane", text: "Pane")
          end
        end
      end
    end
  end

  def test_inner_spacing
    Primer::Beta::Layout::INNER_SPACING_OPTIONS.each do |size|
      render_inline(Primer::Beta::Layout.new(inner_spacing: size)) do |c|
        c.main { "Main" }
        c.pane { "Pane" }
      end

      assert_selector("div.LayoutBeta") do
        if size == :none
          assert_selector("div.LayoutBeta") do
            assert_selector("div.LayoutBeta-content", text: "Main")
            assert_selector("div.LayoutBeta-pane", text: "Pane")
          end
        else
          assert_selector("div.LayoutBeta.LayoutBeta--inner-spacing-#{size}") do
            assert_selector("div.LayoutBeta-content", text: "Main")
            assert_selector("div.LayoutBeta-pane", text: "Pane")
          end
        end
      end
    end
  end

  def test_column_gap
    Primer::Beta::Layout::COLUMN_GAP_OPTIONS.each do |size|
      render_inline(Primer::Beta::Layout.new(column_gap: size)) do |c|
        c.main { "Main" }
        c.pane { "Pane" }
      end

      assert_selector("div.LayoutBeta") do
        if size == :none
          assert_selector("div.LayoutBeta") do
            assert_selector("div.LayoutBeta-content", text: "Main")
            assert_selector("div.LayoutBeta-pane", text: "Pane")
          end
        else
          assert_selector("div.LayoutBeta.LayoutBeta--column-gap-#{size}") do
            assert_selector("div.LayoutBeta-content", text: "Main")
            assert_selector("div.LayoutBeta-pane", text: "Pane")
          end
        end
      end
    end
  end

  def test_row_gap
    Primer::Beta::Layout::ROW_GAP_OPTIONS.each do |size|
      render_inline(Primer::Beta::Layout.new(row_gap: size)) do |c|
        c.main { "Main" }
        c.pane { "Pane" }
      end

      assert_selector("div.LayoutBeta") do
        if size == :none
          assert_selector("div.LayoutBeta") do
            assert_selector("div.LayoutBeta-content", text: "Main")
            assert_selector("div.LayoutBeta-pane", text: "Pane")
          end
        else
          assert_selector("div.LayoutBeta.LayoutBeta--row-gap-#{size}") do
            assert_selector("div.LayoutBeta-content", text: "Main")
            assert_selector("div.LayoutBeta-pane", text: "Pane")
          end
        end
      end
    end
  end
  # def test_main_width
  #   Primer::Beta::Layout::Main::WIDTH_OPTIONS.each do |width|
  #     render_inline(Primer::Beta::Layout.new) do |c|
  #       c.main(width: width) { "Main" }
  #       c.sidebar { "Sidebar" }
  #     end

  #     assert_selector("div.Layout.Layout--sidebarPosition-start") do
  #       assert_selector("div.Layout-main") do
  #         if width == :full
  #           assert_text("Main")
  #         else
  #           assert_selector("div.Layout-main-centered-#{width}") do
  #             assert_selector("div.container-#{width}", text: "Main")
  #           end
  #         end
  #       end
  #       assert_selector("div.Layout-sidebar", text: "Sidebar")
  #     end
  #   end
  # end

  # def test_sidebar_col_placement
  #   render_inline(Primer::Beta::Layout.new) do |c|
  #     c.main { "Main" }
  #     c.sidebar(col_placement: :end) { "Sidebar" }
  #   end

  #   assert_selector("div.Layout.Layout--sidebarPosition-end")
  # end

  # def test_gutter
  #   (Primer::Beta::Layout::GUTTER_OPTIONS - [Primer::Beta::Layout::GUTTER_DEFAULT]).each do |gutter|
  #     render_inline(Primer::Beta::Layout.new(gutter: gutter)) do |c|
  #       c.main { "Main" }
  #       c.sidebar { "Sidebar" }
  #     end

  #     gutter_class = Primer::Beta::Layout::GUTTER_MAPPINGS[gutter]
  #     assert_selector("div.#{gutter_class}")
  #   end
  # end

  # def test_stacking_breakpoint
  #   (Primer::Beta::Layout::STACKING_BREAKPOINT_OPTIONS - [Primer::Beta::Layout::STACKING_BREAKPOINT_DEFAULT]).each do |stacking_breakpoint|
  #     render_inline(Primer::Beta::Layout.new(stacking_breakpoint: stacking_breakpoint)) do |c|
  #       c.main { "Main" }
  #       c.sidebar { "Sidebar" }
  #     end

  #     breakpoint_class = Primer::Beta::Layout::STACKING_BREAKPOINT_MAPPINGS[stacking_breakpoint]
  #     assert_selector("div.Layout#{breakpoint_class.empty? ? '' : ".#{breakpoint_class}"}")
  #   end
  # end

  # def test_sidebar_row_placement
  #   Primer::Beta::Layout::SIDEBAR_ROW_PLACEMENT_OPTIONS.each do |row_placement|
  #     render_inline(Primer::Beta::Layout.new) do |c|
  #       c.main { "Main" }
  #       c.sidebar(row_placement: row_placement) { "Sidebar" }
  #     end

  #     assert_selector("div.Layout.Layout--sidebarPosition-flowRow-#{row_placement}")
  #   end
  # end

  # def test_sidebar_width
  #   Primer::Beta::Layout::SIDEBAR_WIDTH_OPTIONS.each do |width|
  #     next if width == :default

  #     render_inline(Primer::Beta::Layout.new) do |c|
  #       c.main { "Main" }
  #       c.sidebar(width: width) { "Sidebar" }
  #     end

  #     assert_selector("div.Layout.Layout--sidebar-#{width}")
  #   end
  # end

  # def test_sidebar_first_in_html
  #   render_inline(Primer::Beta::Layout.new) do |c|
  #     c.main { "Main" }
  #     c.sidebar { "Sidebar" }
  #   end

  #   assert_match(/Layout-sidebar.*Layout-main/m, @rendered_component)
  # end

  # def test_main_first_in_html
  #   render_inline(Primer::Beta::Layout.new(first_in_source: :main)) do |c|
  #     c.main { "Main" }
  #     c.sidebar { "Sidebar" }
  #   end

  #   assert_match(/Layout-main.*Layout-sidebar/m, @rendered_component)
  # end

  # def test_renders_main_slot_as_different_elements
  #   Primer::Beta::Layout::Main::TAG_OPTIONS.each do |tag|
  #     render_inline(Primer::Beta::Layout.new) do |c|
  #       c.main(tag: tag) { "Main" }
  #       c.sidebar { "Sidebar" }
  #     end

  #     assert_selector("div.Layout.Layout--sidebarPosition-start") do
  #       assert_selector("#{tag}.Layout-main", text: "Main")
  #       assert_selector("div.Layout-sidebar", text: "Sidebar")
  #     end
  #   end
  # end

  # def test_renders_sidebar_slot_as_different_elements
  #   Primer::Beta::Layout::Sidebar::TAG_OPTIONS.each do |tag|
  #     render_inline(Primer::Beta::Layout.new) do |c|
  #       c.main { "Main" }
  #       c.sidebar(tag: tag) { "Sidebar" }
  #     end

  #     assert_selector("div.Layout.Layout--sidebarPosition-start") do
  #       assert_selector("div.Layout-main", text: "Main")
  #       assert_selector("#{tag}.Layout-sidebar", text: "Sidebar")
  #     end
  #   end
  # end
end
