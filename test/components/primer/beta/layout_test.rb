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

  def test_optionally_renders_header
    render_inline(Primer::Beta::Layout.new) do |c|
      c.header { "Header" }
      c.main { "Main" }
      c.pane { "Pane" }
    end

    assert_selector("div.LayoutBeta") do
      assert_selector("div.LayoutBeta-header", text: "Header")
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
        assert_selector("div.LayoutBeta-regions#{size == :fluid ? '' : ".container-#{size}"}") do
          assert_selector("div.LayoutBeta-content", text: "Main")
          assert_selector("div.LayoutBeta-pane", text: "Pane")
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

      size_class = Primer::Beta::Layout::OUTER_SPACING_MAPPINGS[size]
      assert_selector("div.LayoutBeta#{size_class.empty? ? '' : ".#{size_class}"}") do
        assert_selector("div.LayoutBeta-content", text: "Main")
        assert_selector("div.LayoutBeta-pane", text: "Pane")
      end
    end
  end

  def test_inner_spacing
    Primer::Beta::Layout::INNER_SPACING_OPTIONS.each do |size|
      render_inline(Primer::Beta::Layout.new(inner_spacing: size)) do |c|
        c.main { "Main" }
        c.pane { "Pane" }
      end

      size_class = Primer::Beta::Layout::INNER_SPACING_MAPPINGS[size]
      assert_selector("div.LayoutBeta#{size_class.empty? ? '' : ".#{size_class}"}") do
        assert_selector("div.LayoutBeta-content", text: "Main")
        assert_selector("div.LayoutBeta-pane", text: "Pane")
      end
    end
  end

  def test_column_gap
    Primer::Beta::Layout::COLUMN_GAP_OPTIONS.each do |size|
      render_inline(Primer::Beta::Layout.new(column_gap: size)) do |c|
        c.main { "Main" }
        c.pane { "Pane" }
      end

      size_class = Primer::Beta::Layout::COLUMN_GAP_MAPPINGS[size]
      assert_selector("div.LayoutBeta#{size_class.empty? ? '' : ".#{size_class}"}") do
        assert_selector("div.LayoutBeta-content", text: "Main")
        assert_selector("div.LayoutBeta-pane", text: "Pane")
      end
    end
  end

  def test_row_gap
    Primer::Beta::Layout::ROW_GAP_OPTIONS.each do |size|
      render_inline(Primer::Beta::Layout.new(row_gap: size)) do |c|
        c.main { "Main" }
        c.pane { "Pane" }
      end

      size_class = Primer::Beta::Layout::ROW_GAP_MAPPINGS[size]
      assert_selector("div.LayoutBeta#{size_class.empty? ? '' : ".#{size_class}"}") do
        assert_selector("div.LayoutBeta-content", text: "Main")
        assert_selector("div.LayoutBeta-pane", text: "Pane")
      end
    end
  end

  def test_responsive_behaviour
    Primer::Beta::Layout::RESPONSIVE_BEHAVIOR_OPTIONS.each do |behavior|
      render_inline(Primer::Beta::Layout.new(responsive_behavior: behavior)) do |c|
        c.main { "Main" }
        c.pane { "Pane" }
      end

      behavior_class = Primer::Beta::Layout::RESPONSIVE_BEHAVIOR_MAPPINGS[behavior]
      assert_selector("div.LayoutBeta#{behavior_class.empty? ? '' : ".#{behavior_class}"}") do
        assert_selector("div.LayoutBeta-content", text: "Main")
        assert_selector("div.LayoutBeta-pane", text: "Pane")
      end
    end
  end

  def test_responsive_show_pane_first
    render_inline(Primer::Beta::Layout.new(responsive_show_pane_first: true)) do |c|
      c.main { "Main" }
      c.pane { "Pane" }
    end

    assert_selector("div.LayoutBeta.LayoutBeta--responsive-pane-first") do
      assert_selector("div.LayoutBeta-content", text: "Main")
      assert_selector("div.LayoutBeta-pane", text: "Pane")
    end
  end

  def test_responsive_show_pane_first_not_set_by_default
    render_inline(Primer::Beta::Layout.new) do |c|
      c.main { "Main" }
      c.pane { "Pane" }
    end

    refute_selector("div.LayoutBeta.LayoutBeta--responsive-pane-first")
  end

  def test_pane_position
    Primer::Beta::Layout::PANE_POSITION_OPTIONS.each do |position|
      render_inline(Primer::Beta::Layout.new) do |c|
        c.main { "Main" }
        c.pane(position: position) { "Pane" }
      end

      assert_selector("div.LayoutBeta") do
        assert_selector("div.LayoutBeta--pane-position-#{position}") do
          assert_selector("div.LayoutBeta-content", text: "Main")
          assert_selector("div.LayoutBeta-pane", text: "Pane")
        end
      end
    end
  end

  def test_pane_responsive_position
    Primer::Beta::Layout::PANE_RESPONSIVE_POSITION_OPTIONS.each do |position|
      render_inline(Primer::Beta::Layout.new) do |c|
        c.main { "Main" }
        c.pane(responsive_position: position) { "Pane" }
      end

      # When set to `:inherit`, the responsive position is inherited from `position`
      if position == Primer::Beta::Layout::PANE_RESPONSIVE_POSITION_DEFAULT
        assert_selector("div.LayoutBeta") do
          assert_selector("div.LayoutBeta--pane-responsive-position-start") do
            assert_selector("div.LayoutBeta-content", text: "Main")
            assert_selector("div.LayoutBeta-pane", text: "Pane")
          end
        end
      else
        assert_selector("div.LayoutBeta") do
          assert_selector("div.LayoutBeta--pane-responsive-position-#{position}") do
            assert_selector("div.LayoutBeta-content", text: "Main")
            assert_selector("div.LayoutBeta-pane", text: "Pane")
          end
        end
      end
    end
  end

  def test_pane_width
    Primer::Beta::Layout::PANE_WIDTH_OPTIONS.each do |size|
      render_inline(Primer::Beta::Layout.new) do |c|
        c.main { "Main" }
        c.pane(width: size) { "Pane" }
      end

      width_class = Primer::Beta::Layout::PANE_WIDTH_MAPPINGS[size]
      assert_selector("div.LayoutBeta") do
        assert_selector("div#{width_class.empty? ? '' : ".#{width_class}"}") do
          assert_selector("div.LayoutBeta-content", text: "Main")
          assert_selector("div.LayoutBeta-pane", text: "Pane")
        end
      end
    end
  end

  def test_pane_divider_present_when_set
    render_inline(Primer::Beta::Layout.new) do |c|
      c.main { "Main" }
      c.pane(divider: true) { "Pane" }
    end

    assert_selector("div.LayoutBeta.LayoutBeta--pane-divider") do
      assert_selector("div.LayoutBeta-content", text: "Main")
      assert_selector("div.LayoutBeta-pane", text: "Pane")
    end
  end

  def test_pane_divider_absent_when_not_set
    render_inline(Primer::Beta::Layout.new) do |c|
      c.main { "Main" }
      c.pane { "Pane" }
    end

    refute_selector("div.LayoutBeta.LayoutBeta--pane-divider")
  end

  def test_pane_sticky_present_when_set
    render_inline(Primer::Beta::Layout.new) do |c|
      c.main { "Main" }
      c.pane(sticky: true) { "Pane" }
    end

    assert_selector("div.LayoutBeta.LayoutBeta--pane-is-sticky") do
      assert_selector("div.LayoutBeta-content", text: "Main")
      assert_selector("div.LayoutBeta-pane", text: "Pane")
    end
  end

  def test_pane_sticky_absent_when_not_set
    render_inline(Primer::Beta::Layout.new) do |c|
      c.main { "Main" }
      c.pane { "Pane" }
    end

    refute_selector("div.LayoutBeta.LayoutBeta--pane-divider")
  end

  def test_header_class_present_when_header_present
    render_inline(Primer::Beta::Layout.new) do |c|
      c.header { "Header" }
      c.main { "Main" }
      c.pane { "Pane" }
    end

    assert_selector("div.LayoutBeta.LayoutBeta--has-header")
  end

  def test_header_divider_present_when_set
    render_inline(Primer::Beta::Layout.new) do |c|
      c.header(divider: true) { "Header" }
      c.main { "Main" }
      c.pane { "Pane" }
    end

    assert_selector("div.LayoutBeta.LayoutBeta--has-header.LayoutBeta--header-divider")
  end

  def test_header_divider_not_present_when_not_set
    render_inline(Primer::Beta::Layout.new) do |c|
      c.header { "Header" }
      c.main { "Main" }
      c.pane { "Pane" }
    end

    refute_selector("div.LayoutBeta.LayoutBeta--has-header.LayoutBeta--header-divider")
  end

  def test_header_responsive_divider
    Primer::Beta::Layout::Bookend::RESPONSIVE_DIVIDER_OPTIONS.each do |opt|
      render_inline(Primer::Beta::Layout.new) do |c|
        c.header(responsive_divider: opt) { "Header" }
        c.main { "Main" }
        c.pane { "Pane" }
      end

      divider_class = Primer::Beta::Layout::Bookend::RESPONSIVE_DIVIDER_MAPPINGS[opt]
      assert_selector("div.LayoutBeta") do
        assert_selector("div.LayoutBeta-header#{divider_class.empty? ? '' : ".#{divider_class}"}", text: "Header")
        assert_selector("div.LayoutBeta-content", text: "Main")
        assert_selector("div.LayoutBeta-pane", text: "Pane")
      end
    end
  end

  def test_footer_class_present_when_footer_present
    render_inline(Primer::Beta::Layout.new) do |c|
      c.main { "Main" }
      c.pane { "Pane" }
      c.footer { "Footer" }
    end

    assert_selector("div.LayoutBeta.LayoutBeta--has-footer")
  end

  def test_footer_divider_present_when_set
    render_inline(Primer::Beta::Layout.new) do |c|
      c.main { "Main" }
      c.pane { "Pane" }
      c.footer(divider: true) { "Footer" }
    end

    assert_selector("div.LayoutBeta.LayoutBeta--has-footer.LayoutBeta--footer-divider")
  end

  def test_footer_divider_not_present_when_not_set
    render_inline(Primer::Beta::Layout.new) do |c|
      c.main { "Main" }
      c.pane { "Pane" }
      c.footer { "Footer" }
    end

    refute_selector("div.LayoutBeta.LayoutBeta--has-footer.LayoutBeta--footer-divider")
  end

  def test_footer_responsive_divider
    Primer::Beta::Layout::Bookend::RESPONSIVE_DIVIDER_OPTIONS.each do |opt|
      render_inline(Primer::Beta::Layout.new) do |c|
        c.main { "Main" }
        c.pane { "Pane" }
        c.footer(responsive_divider: opt) { "Footer" }
      end

      divider_class = Primer::Beta::Layout::Bookend::RESPONSIVE_DIVIDER_MAPPINGS[opt]
      assert_selector("div.LayoutBeta") do
        assert_selector("div.LayoutBeta-footer#{divider_class.empty? ? '' : ".#{divider_class}"}", text: "Footer")
        assert_selector("div.LayoutBeta-content", text: "Main")
        assert_selector("div.LayoutBeta-pane", text: "Pane")
      end
    end
  end
end
