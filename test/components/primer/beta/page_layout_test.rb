# frozen_string_literal: true

require "test_helper"

class PrimerBetaPageLayoutTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_doesnt_render_without_both_slots
    render_inline(Primer::Beta::PageLayout.new)
    refute_component_rendered

    render_inline(Primer::Beta::PageLayout.new) { |c| c.main { "Main" } }
    refute_component_rendered

    render_inline(Primer::Beta::PageLayout.new) { |c| c.pane { "Pane" } }
    refute_component_rendered
  end

  def test_renders_layout
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.main { "Main" }
      c.pane { "Pane" }
    end

    assert_selector("div.LayoutBeta") do
      assert_selector("div.LayoutBeta-content", text: "Main")
      assert_selector("div.LayoutBeta-pane", text: "Pane")
    end
  end

  def test_optionally_renders_header_and_footer
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.header { "Header" }
      c.main { "Main" }
      c.pane { "Pane" }
      c.footer { "Footer" }
    end

    assert_selector("div.LayoutBeta") do
      assert_selector("div.LayoutBeta-header", text: "Header")
      assert_selector("div.LayoutBeta-content", text: "Main")
      assert_selector("div.LayoutBeta-pane", text: "Pane")
      assert_selector("div.LayoutBeta-footer", text: "Footer")
    end
  end

  def test_wrapper_sizing
    Primer::Beta::PageLayout::WRAPPER_SIZING_OPTIONS.each do |size|
      render_inline(Primer::Beta::PageLayout.new(wrapper_sizing: size)) do |c|
        c.main { "Main" }
        c.pane { "Pane" }
      end

      assert_selector("div.LayoutBeta") do
        assert_selector("div.LayoutBeta-wrapper#{size == :fluid ? '' : ".container-#{size}"}") do
          assert_selector("div.LayoutBeta-content", text: "Main")
          assert_selector("div.LayoutBeta-pane", text: "Pane")
        end
      end
    end
  end

  def test_renders_layout_with_correct_default_classes
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.main { "Main" }
      c.pane { "Pane" }
    end

    expected_classes = [
      "LayoutBeta",
      "LayoutBeta--variant-stackRegions",
      "LayoutBeta--variant-md-multiColumns",
      "LayoutBeta--outer-spacing-normal",
      "LayoutBeta--column-gap-normal",
      "LayoutBeta--row-gap-normal",
      "LayoutBeta--pane-position-start",
      "LayoutBeta--stackRegions-pane-position-start"
    ].join(".")
    assert_selector("div.#{expected_classes}") do
      assert_selector("div.LayoutBeta-content", text: "Main")
      assert_selector("div.LayoutBeta-pane", text: "Pane")
    end
  end

  def test_outer_spacing
    Primer::Beta::PageLayout::OUTER_SPACING_OPTIONS.each do |size|
      render_inline(Primer::Beta::PageLayout.new(outer_spacing: size)) do |c|
        c.main { "Main" }
        c.pane { "Pane" }
      end

      size_class = Primer::Beta::PageLayout::OUTER_SPACING_MAPPINGS[size]
      assert_selector("div.LayoutBeta#{size_class.empty? ? '' : ".#{size_class}"}") do
        assert_selector("div.LayoutBeta-content", text: "Main")
        assert_selector("div.LayoutBeta-pane", text: "Pane")
      end
    end
  end

  def test_column_gap
    Primer::Beta::PageLayout::COLUMN_GAP_OPTIONS.each do |size|
      render_inline(Primer::Beta::PageLayout.new(column_gap: size)) do |c|
        c.main { "Main" }
        c.pane { "Pane" }
      end

      size_class = Primer::Beta::PageLayout::COLUMN_GAP_MAPPINGS[size]
      assert_selector("div.LayoutBeta#{size_class.empty? ? '' : ".#{size_class}"}") do
        assert_selector("div.LayoutBeta-content", text: "Main")
        assert_selector("div.LayoutBeta-pane", text: "Pane")
      end
    end
  end

  def test_row_gap
    Primer::Beta::PageLayout::ROW_GAP_OPTIONS.each do |size|
      render_inline(Primer::Beta::PageLayout.new(row_gap: size)) do |c|
        c.main { "Main" }
        c.pane { "Pane" }
      end

      size_class = Primer::Beta::PageLayout::ROW_GAP_MAPPINGS[size]
      assert_selector("div.LayoutBeta#{size_class.empty? ? '' : ".#{size_class}"}") do
        assert_selector("div.LayoutBeta-content", text: "Main")
        assert_selector("div.LayoutBeta-pane", text: "Pane")
      end
    end
  end

  def test_responsive_primary_region
    Primer::Beta::PageLayout::RESPONSIVE_PRIMARY_REGION_OPTIONS.each do |region|
      render_inline(Primer::Beta::PageLayout.new(responsive_primary_region: region)) do |c|
        c.main { "Main" }
        c.pane { "Pane" }
      end

      region_class = Primer::Beta::PageLayout::RESPONSIVE_PRIMARY_REGION_MAPPINGS[region]
      assert_selector("div.LayoutBeta#{region_class.empty? ? '' : ".#{region_class}"}") do
        assert_selector("div.LayoutBeta-content", text: "Main")
        assert_selector("div.LayoutBeta-pane", text: "Pane")
      end
    end
  end

  def test_responsive_variant
    Primer::Beta::PageLayout::RESPONSIVE_VARIANT_OPTIONS.each do |variant|
      render_inline(Primer::Beta::PageLayout.new(responsive_variant: variant)) do |c|
        c.main { "Main" }
        c.pane { "Pane" }
      end

      variant_class = Primer::Beta::PageLayout::RESPONSIVE_VARIANT_MAPPINGS[variant]
      assert_selector("div.LayoutBeta#{variant_class.empty? ? '' : ".#{variant_class}"}") do
        assert_selector("div.LayoutBeta-content", text: "Main")
        assert_selector("div.LayoutBeta-pane", text: "Pane")
      end
    end
  end

  def test_pane_width
    Primer::Beta::PageLayout::PANE_WIDTH_OPTIONS.each do |size|
      render_inline(Primer::Beta::PageLayout.new) do |c|
        c.main { "Main" }
        c.pane(width: size) { "Pane" }
      end

      width_class = Primer::Beta::PageLayout::PANE_WIDTH_MAPPINGS[size]
      assert_selector("div.LayoutBeta") do
        assert_selector("div#{width_class.empty? ? '' : ".#{width_class}"}") do
          assert_selector("div.LayoutBeta-content", text: "Main")
          assert_selector("div.LayoutBeta-pane", text: "Pane")
        end
      end
    end
  end

  def test_pane_divider_present_when_set
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.main { "Main" }
      c.pane(divider: true) { "Pane" }
    end

    assert_selector("div.LayoutBeta.LayoutBeta--pane-divider") do
      assert_selector("div.LayoutBeta-content", text: "Main")
      assert_selector("div.LayoutBeta-pane", text: "Pane")
    end
  end

  def test_pane_divider_absent_when_not_set
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.main { "Main" }
      c.pane { "Pane" }
    end

    refute_selector("div.LayoutBeta.LayoutBeta--pane-divider")
  end

  def test_pane_position_add_correct_class
    Primer::Beta::PageLayout::Pane::POSITION_OPTIONS.each do |position|
      render_inline(Primer::Beta::PageLayout.new) do |c|
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

  def test_pane_position_renders_pane_first
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.main { "Main" }
      c.pane(position: :start) { "Pane" }
    end

    assert_match(/LayoutBeta-pane.*LayoutBeta-content/m, @rendered_component)
  end

  def test_pane_position_renders_pane_last
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.main { "Main" }
      c.pane(position: :end) { "Pane" }
    end

    assert_match(/LayoutBeta-content.*LayoutBeta-pane/m, @rendered_component)
  end

  def test_pane_responsive_position
    Primer::Beta::PageLayout::PANE_RESPONSIVE_POSITION_OPTIONS.each do |position|
      render_inline(Primer::Beta::PageLayout.new) do |c|
        c.main { "Main" }
        c.pane(responsive_position: position) { "Pane" }
      end

      position_class = Primer::Beta::PageLayout::PANE_RESPONSIVE_POSITION_MAPPINGS[position]
      assert_selector("div.LayoutBeta#{position_class.empty? ? '' : ".#{position_class}"}") do
        assert_selector("div.LayoutBeta-content", text: "Main")
        assert_selector("div.LayoutBeta-pane", text: "Pane")
      end
    end
  end

  def test_main_width
    Primer::Beta::PageLayout::Main::WIDTH_OPTIONS.each do |width|
      render_inline(Primer::Beta::PageLayout.new) do |c|
        c.main(width: width) { "Main" }
        c.pane { "Pane" }
      end

      assert_selector("div.LayoutBeta-regions") do
        assert_selector("div.LayoutBeta-content") do
          if width == :fluid
            assert_text("Main")
          else
            assert_selector("div.LayoutBeta-content-centered-#{width}") do
              assert_selector("div.container-#{width}", text: "Main")
            end
          end
        end
        assert_selector("div.LayoutBeta-pane", text: "Pane")
      end
    end
  end

  def test_header_divider_present_when_set
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.header(divider: true) { "Header" }
      c.main { "Main" }
      c.pane { "Pane" }
    end

    assert_selector("div.LayoutBeta.LayoutBeta--header-divider")
  end

  def test_header_divider_not_present_when_not_set
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.header { "Header" }
      c.main { "Main" }
      c.pane { "Pane" }
    end

    refute_selector("div.LayoutBeta.LayoutBeta--has-header.LayoutBeta--header-divider")
  end

  def test_header_responsive_divider
    Primer::Beta::PageLayout::Bookend::RESPONSIVE_DIVIDER_OPTIONS.each do |opt|
      render_inline(Primer::Beta::PageLayout.new) do |c|
        c.header(responsive_divider: opt) { "Header" }
        c.main { "Main" }
        c.pane { "Pane" }
      end

      divider_class = Primer::Beta::PageLayout::Bookend::RESPONSIVE_DIVIDER_MAPPINGS[opt]
      assert_selector("div.LayoutBeta") do
        assert_selector("div.LayoutBeta-header#{divider_class.empty? ? '' : ".#{divider_class}"}", text: "Header")
        assert_selector("div.LayoutBeta-content", text: "Main")
        assert_selector("div.LayoutBeta-pane", text: "Pane")
      end
    end
  end

  def test_footer_divider_present_when_set
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.main { "Main" }
      c.pane { "Pane" }
      c.footer(divider: true) { "Footer" }
    end

    assert_selector("div.LayoutBeta.LayoutBeta--has-footer.LayoutBeta--footer-divider")
  end

  def test_footer_divider_not_present_when_not_set
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.main { "Main" }
      c.pane { "Pane" }
      c.footer { "Footer" }
    end

    refute_selector("div.LayoutBeta.LayoutBeta--has-footer.LayoutBeta--footer-divider")
  end

  def test_footer_responsive_divider
    Primer::Beta::PageLayout::Bookend::RESPONSIVE_DIVIDER_OPTIONS.each do |opt|
      render_inline(Primer::Beta::PageLayout.new) do |c|
        c.main { "Main" }
        c.pane { "Pane" }
        c.footer(responsive_divider: opt) { "Footer" }
      end

      divider_class = Primer::Beta::PageLayout::Bookend::RESPONSIVE_DIVIDER_MAPPINGS[opt]
      assert_selector("div.LayoutBeta") do
        assert_selector("div.LayoutBeta-footer#{divider_class.empty? ? '' : ".#{divider_class}"}", text: "Footer")
        assert_selector("div.LayoutBeta-content", text: "Main")
        assert_selector("div.LayoutBeta-pane", text: "Pane")
      end
    end
  end
end
