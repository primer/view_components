# frozen_string_literal: true

require "test_helper"

class PrimerBetaPageLayoutTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_doesnt_render_without_both_slots
    render_inline(Primer::Beta::PageLayout.new)
    refute_component_rendered

    render_inline(Primer::Beta::PageLayout.new) { |c| c.content_region { "Content" } }
    refute_component_rendered

    render_inline(Primer::Beta::PageLayout.new) { |c| c.pane_region { "Pane" } }
    refute_component_rendered
  end

  def test_renders_layout
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.content_region { "Content" }
      c.pane_region { "Pane" }
    end

    assert_selector("div.PageLayout") do
      assert_selector("div.PageLayout-columns") do
        assert_selector("div.PageLayout-region.PageLayout-content", text: "Content")
        assert_selector("div.PageLayout-region.PageLayout-pane", text: "Pane")
      end
    end
  end

  def test_optionally_renders_header_and_footer
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.header_region { "Header" }
      c.content_region { "Content" }
      c.pane_region { "Pane" }
      c.footer_region { "Footer" }
    end

    assert_selector("div.PageLayout") do
      assert_selector("div.PageLayout-header.PageLayout-region", text: "Header")
      assert_selector("div.PageLayout-columns") do
        assert_selector("div.PageLayout-region.PageLayout-content", text: "Content")
        assert_selector("div.PageLayout-region.PageLayout-pane", text: "Pane")
      end
      assert_selector("div.PageLayout-footer.PageLayout-region", text: "Footer")
    end
  end

  def test_renders_layout_with_correct_default_classes
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.content_region { "Content" }
      c.pane_region { "Pane" }
    end

    expected_classes = [
      "PageLayout",
      "PageLayout--responsive-stackRegions",
      "PageLayout--outerSpacing-normal",
      "PageLayout--columnGap-normal",
      "PageLayout--rowGap-normal",
      "PageLayout--panePos-start",
      "PageLayout--responsive-panePos-start"
    ].join(".")
    assert_selector("div.#{expected_classes}") do
      assert_selector("div.PageLayout-content", text: "Content")
      assert_selector("div.PageLayout-pane", text: "Pane")
    end
  end

  def test_wrapper_sizing
    Primer::Beta::PageLayout::WRAPPER_SIZING_OPTIONS.each do |size|
      render_inline(Primer::Beta::PageLayout.new(wrapper_sizing: size)) do |c|
        c.content_region { "Content" }
        c.pane_region { "Pane" }
      end

      assert_selector("div.PageLayout") do
        assert_selector("div.PageLayout-wrapper#{size == :fluid ? '' : ".container-#{size}"}") do
          assert_selector("div.PageLayout-content", text: "Content")
          assert_selector("div.PageLayout-pane", text: "Pane")
        end
      end
    end
  end

  def test_outer_spacing
    Primer::Beta::PageLayout::OUTER_SPACING_OPTIONS.each do |size|
      render_inline(Primer::Beta::PageLayout.new(outer_spacing: size)) do |c|
        c.content_region { "Content" }
        c.pane_region { "Pane" }
      end

      size_class = Primer::Beta::PageLayout::OUTER_SPACING_MAPPINGS[size]
      assert_selector("div.PageLayout#{size_class.empty? ? '' : ".#{size_class}"}") do
        assert_selector("div.PageLayout-content", text: "Content")
        assert_selector("div.PageLayout-pane", text: "Pane")
      end
    end
  end

  def test_column_gap
    Primer::Beta::PageLayout::COLUMN_GAP_OPTIONS.each do |size|
      render_inline(Primer::Beta::PageLayout.new(column_gap: size)) do |c|
        c.content_region { "Content" }
        c.pane_region { "Pane" }
      end

      size_class = Primer::Beta::PageLayout::COLUMN_GAP_MAPPINGS[size]
      assert_selector("div.PageLayout#{size_class.empty? ? '' : ".#{size_class}"}") do
        assert_selector("div.PageLayout-content", text: "Content")
        assert_selector("div.PageLayout-pane", text: "Pane")
      end
    end
  end

  def test_row_gap
    Primer::Beta::PageLayout::ROW_GAP_OPTIONS.each do |size|
      render_inline(Primer::Beta::PageLayout.new(row_gap: size)) do |c|
        c.content_region { "Content" }
        c.pane_region { "Pane" }
      end

      size_class = Primer::Beta::PageLayout::ROW_GAP_MAPPINGS[size]
      assert_selector("div.PageLayout#{size_class.empty? ? '' : ".#{size_class}"}") do
        assert_selector("div.PageLayout-content", text: "Content")
        assert_selector("div.PageLayout-pane", text: "Pane")
      end
    end
  end

  def test_responsive_variant
    Primer::Beta::PageLayout::RESPONSIVE_VARIANT_OPTIONS.each do |variant|
      render_inline(Primer::Beta::PageLayout.new(responsive_variant: variant)) do |c|
        c.content_region { "Content" }
        c.pane_region { "Pane" }
      end

      variant_class = Primer::Beta::PageLayout::RESPONSIVE_VARIANT_MAPPINGS[variant]
      assert_selector("div.PageLayout#{variant_class.empty? ? '' : ".#{variant_class}"}") do
        assert_selector("div.PageLayout-content", text: "Content")
        assert_selector("div.PageLayout-pane", text: "Pane")
      end
    end
  end

  def test_primary_region
    Primer::Beta::PageLayout::PRIMARY_REGION_OPTIONS.each do |region|
      render_inline(Primer::Beta::PageLayout.new(responsive_variant: :separate_regions, primary_region: region)) do |c|
        c.content_region { "Content" }
        c.pane_region { "Pane" }
      end

      region_class = Primer::Beta::PageLayout::PRIMARY_REGION_MAPPINGS[region]
      assert_selector("div.PageLayout#{region_class.empty? ? '' : ".#{region_class}"}") do
        assert_selector("div.PageLayout-content", text: "Content")
        assert_selector("div.PageLayout-pane", text: "Pane")
      end
    end
  end

  def test_primary_region_not_set_when_stack_regions
    render_inline(Primer::Beta::PageLayout.new(responsive_variant: :stack_regions)) do |c|
      c.content_region { "Content" }
      c.pane_region { "Pane" }
    end

    refute_selector("div.PageLayout--responsive-primary-pane")
    refute_selector("div.PageLayout--responsive-primary-content")
  end

  def test_pane_position
    Primer::Beta::PageLayout::Pane::POSITION_OPTIONS.each do |position|
      render_inline(Primer::Beta::PageLayout.new) do |c|
        c.content_region { "Content" }
        c.pane_region(position: position) { "Pane" }
      end

      assert_selector("div.PageLayout") do
        assert_selector("div.PageLayout--panePos-#{position}") do
          assert_selector("div.PageLayout-content", text: "Content")
          assert_selector("div.PageLayout-pane", text: "Pane")
        end
      end
    end
  end

  def test_pane_position_renders_pane_first
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.content_region { "Content" }
      c.pane_region(position: :start) { "Pane" }
    end

    assert_match(/PageLayout-pane.*PageLayout-content/m, @rendered_component)
  end

  def test_pane_position_renders_pane_last
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.content_region { "Content" }
      c.pane_region(position: :end) { "Pane" }
    end

    assert_match(/PageLayout-content.*PageLayout-pane/m, @rendered_component)
  end

  def test_stack_regions_variant_with_pane_position_narrow
    Primer::Beta::PageLayout::Pane::POSITION_OPTIONS.each do |position|
      Primer::Beta::PageLayout::Pane::POSITION_NARROW_OPTIONS.each do |position_narrow|
        render_inline(Primer::Beta::PageLayout.new(responsive_variant: :stack_regions)) do |c|
          c.content_region { "Content" }
          c.pane_region(position: position, position_narrow: position_narrow) { "Pane" }
        end

        position_narrow = position if position_narrow == :inherit
        assert_selector("div.PageLayout") do
          assert_selector("div.PageLayout--panePos-#{position}.PageLayout--responsive-panePos-#{position_narrow}") do
            assert_selector("div.PageLayout-content", text: "Content")
            assert_selector("div.PageLayout-pane", text: "Pane")
          end
        end
      end
    end
  end

  def test_variant_pane_position_not_set_when_separate_regions
    render_inline(Primer::Beta::PageLayout.new(responsive_variant: :separate_regions)) do |c|
      c.content_region { "Content" }
      c.pane_region(position: :start) { "Pane" }
    end

    refute_selector("div.PageLayout--responsive-panePos-end")
    refute_selector("div.PageLayout--responsive-panePos-start")
  end

  def test_pane_width
    Primer::Beta::PageLayout::Pane::WIDTH_OPTIONS.each do |size|
      render_inline(Primer::Beta::PageLayout.new) do |c|
        c.content_region { "Content" }
        c.pane_region(width: size) { "Pane" }
      end

      width_class = Primer::Beta::PageLayout::Pane::WIDTH_MAPPINGS[size]
      assert_selector("div.PageLayout") do
        assert_selector("div#{width_class.empty? ? '' : ".#{width_class}"}") do
          assert_selector("div.PageLayout-content", text: "Content")
          assert_selector("div.PageLayout-pane", text: "Pane")
        end
      end
    end
  end

  def test_pane_divider_present_when_set
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.content_region { "Content" }
      c.pane_region(divider: true) { "Pane" }
    end

    assert_selector("div.PageLayout.PageLayout--hasPaneDivider") do
      assert_selector("div.PageLayout-content", text: "Content")
      assert_selector("div.PageLayout-pane.PageLayout-region--dividerNarrow-line-after", text: "Pane")
    end
  end

  def test_pane_divider_absent_when_not_set
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.content_region { "Content" }
      c.pane_region { "Pane" }
    end

    refute_selector("div.PageLayout.PageLayout--hasPaneDivider")
  end

  def test_pane_divider_narrow
    Primer::Beta::PageLayout::Pane::POSITION_OPTIONS.each do |position|
      Primer::Beta::PageLayout::Pane::DIVIDER_NARROW_USER_OPTIONS.each do |type|
        render_inline(Primer::Beta::PageLayout.new) do |c|
          c.content_region { "Content" }
          c.pane_region(position: position, divider: true, divider_narrow: type) { "Pane" }
        end

        type_class = Primer::Beta::PageLayout::Pane::DIVIDER_NARROW_MAPPINGS[{position => type}]
        assert_selector("div.PageLayout.PageLayout--hasPaneDivider") do
          assert_selector("div.PageLayout-content", text: "Content")
          assert_selector("div.PageLayout-pane.#{type_class}", text: "Pane")
        end
      end
    end
  end

  def test_pane_divider_narrow_not_applied_when_no_divider
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.content_region { "Content" }
      c.pane_region(position: :start, divider: false, divider_narrow: :line) { "Pane" }
    end

    type_class = Primer::Beta::PageLayout::Pane::DIVIDER_NARROW_MAPPINGS[{ start: :line }]
    refute_selector("div.PageLayout-pane.#{type_class}", text: "Pane")
  end

  def test_pane_tags
    Primer::Beta::PageLayout::Pane::TAG_OPTIONS.each do |tag|
      render_inline(Primer::Beta::PageLayout.new) do |c|
        c.content_region { "Content" }
        c.pane_region(tag: tag) { "Pane" }
      end

      assert_selector("div.PageLayout") do
        assert_selector("div.PageLayout-content", text: "Content")
        assert_selector("#{tag}.PageLayout-pane", text: "Pane")
      end
    end
  end

  def test_main_width
    Primer::Beta::PageLayout::Content::WIDTH_OPTIONS.each do |width|
      render_inline(Primer::Beta::PageLayout.new) do |c|
        c.content_region(width: width) { "Content" }
        c.pane_region { "Pane" }
      end

      assert_selector("div.PageLayout-columns") do
        assert_selector("div.PageLayout-content") do
          if width == :fluid
            assert_text("Content")
          else
            assert_selector("div.PageLayout-content-centered-#{width}") do
              assert_selector("div.container-#{width}", text: "Content")
            end
          end
        end
        assert_selector("div.PageLayout-pane", text: "Pane")
      end
    end
  end

  def test_main_tags
    Primer::Beta::PageLayout::Content::TAG_OPTIONS.each do |tag|
      render_inline(Primer::Beta::PageLayout.new) do |c|
        c.content_region(tag: tag) { "Content" }
        c.pane_region { "Pane" }
      end

      assert_selector("div.PageLayout") do
        assert_selector("#{tag}.PageLayout-content", text: "Content")
        assert_selector("div.PageLayout-pane", text: "Pane")
      end
    end
  end

  def test_header_divider_present_when_set
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.header_region(divider: true) { "Header" }
      c.content_region { "Content" }
      c.pane_region { "Pane" }
    end

    assert_selector("div.PageLayout-header.PageLayout-header--hasDivider.PageLayout-region--dividerNarrow-line-after")
  end

  def test_header_divider_not_present_when_not_set
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.header_region { "Header" }
      c.content_region { "Content" }
      c.pane_region { "Pane" }
    end

    refute_selector("div.PageLayout-header.PageLayout-header--hasDivider")
  end

  def test_header_responsive_divider
    Primer::Beta::PageLayout::HEADER_DIVIDER_NARROW_OPTIONS.each do |opt|
      render_inline(Primer::Beta::PageLayout.new) do |c|
        c.header_region(divider: true, divider_narrow: opt) { "Header" }
        c.content_region { "Content" }
        c.pane_region { "Pane" }
      end

      divider_class = Primer::Beta::PageLayout::HEADER_DIVIDER_NARROW_MAPPINGS[opt]
      assert_selector("div.PageLayout") do
        assert_selector("div.PageLayout-header#{divider_class.empty? ? '' : ".#{divider_class}"}", text: "Header")
        assert_selector("div.PageLayout-content", text: "Content")
        assert_selector("div.PageLayout-pane", text: "Pane")
      end
    end
  end

  def test_footer_divider_present_when_set
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.content_region { "Content" }
      c.pane_region { "Pane" }
      c.footer_region(divider: true) { "Footer" }
    end

    assert_selector("div.PageLayout-footer.PageLayout-footer--hasDivider.PageLayout-region--dividerNarrow-line-before")
  end

  def test_footer_divider_not_present_when_not_set
    render_inline(Primer::Beta::PageLayout.new) do |c|
      c.content_region { "Content" }
      c.pane_region { "Pane" }
      c.footer_region { "Footer" }
    end

    refute_selector("div.PageLayout-footer.PageLayout-footer--hasDivider.PageLayout-region--dividerNarrow-line-before")
  end

  def test_footer_responsive_divider
    Primer::Beta::PageLayout::FOOTER_DIVIDER_NARROW_OPTIONS.each do |opt|
      render_inline(Primer::Beta::PageLayout.new) do |c|
        c.content_region { "Content" }
        c.pane_region { "Pane" }
        c.footer_region(divider: true, divider_narrow: opt) { "Footer" }
      end

      divider_class = Primer::Beta::PageLayout::FOOTER_DIVIDER_NARROW_MAPPINGS[opt]
      assert_selector("div.PageLayout") do
        assert_selector("div.PageLayout-footer#{divider_class.empty? ? '' : ".#{divider_class}"}", text: "Footer")
        assert_selector("div.PageLayout-content", text: "Content")
        assert_selector("div.PageLayout-pane", text: "Pane")
      end
    end
  end
end
