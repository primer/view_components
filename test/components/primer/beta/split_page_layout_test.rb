# frozen_string_literal: true

require "test_helper"

class PrimerBetaSplitPageLayoutTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_doesnt_render_without_both_slots
    render_inline(Primer::Beta::SplitPageLayout.new)
    refute_component_rendered

    render_inline(Primer::Beta::SplitPageLayout.new) { |c| c.content_region { "Content" } }
    refute_component_rendered

    render_inline(Primer::Beta::SplitPageLayout.new) { |c| c.pane_region { "Pane" } }
    refute_component_rendered
  end

  def test_renders_layout
    render_inline(Primer::Beta::SplitPageLayout.new) do |c|
      c.content_region { "Content" }
      c.pane_region { "Pane" }
    end

    assert_selector("div.PageLayout") do
      assert_selector("div.PageLayout-content", text: "Content")
      assert_selector("div.PageLayout-pane", text: "Pane")
    end
  end

  def test_renders_layout_with_correct_default_classes
    render_inline(Primer::Beta::SplitPageLayout.new) do |c|
      c.content_region { "Content" }
      c.pane_region { "Pane" }
    end

    expected_classes = [
      "PageLayout",
      "PageLayout--innerSpacing-normal",
      "PageLayout--columnGap-none",
      "PageLayout--rowGap-none",
      "PageLayout--panePos-start",
      "PageLayout--hasPaneDivider",
      "PageLayout--responsive-separateRegions",
      "PageLayout--responsive-separateRegions-primary-content"
    ].join(".")
    assert_selector("div.#{expected_classes}") do
      assert_selector("div.PageLayout-wrapper") do
        assert_selector("div.PageLayout-columns") do
          assert_selector("div.PageLayout-region.PageLayout-content", text: "Content")
          assert_selector("div.PageLayout-region.PageLayout-pane", text: "Pane")
        end
      end
    end
  end

  def test_responsive_primary_region
    Primer::Beta::SplitPageLayout::RESPONSIVE_PRIMARY_REGION_OPTIONS.each do |region|
      render_inline(Primer::Beta::SplitPageLayout.new(responsive_primary_region: region)) do |c|
        c.content_region { "Content" }
        c.pane_region { "Pane" }
      end

      region_class = Primer::Beta::SplitPageLayout::RESPONSIVE_PRIMARY_REGION_MAPPINGS[region]
      assert_selector("div.PageLayout#{region_class.empty? ? '' : ".#{region_class}"}") do
        assert_selector("div.PageLayout-content", text: "Content")
        assert_selector("div.PageLayout-pane", text: "Pane")
      end
    end
  end

  def test_pane_width
    Primer::Beta::SplitPageLayout::PANE_WIDTH_OPTIONS.each do |size|
      render_inline(Primer::Beta::SplitPageLayout.new) do |c|
        c.content_region { "Content" }
        c.pane_region(width: size) { "Pane" }
      end

      width_class = Primer::Beta::SplitPageLayout::PANE_WIDTH_MAPPINGS[size]
      assert_selector("div.PageLayout") do
        assert_selector("div#{width_class.empty? ? '' : ".#{width_class}"}") do
          assert_selector("div.PageLayout-content", text: "Content")
          assert_selector("div.PageLayout-pane", text: "Pane")
        end
      end
    end
  end

  def test_pane_tags
    Primer::Beta::SplitPageLayout::PANE_TAG_OPTIONS.each do |tag|
      render_inline(Primer::Beta::SplitPageLayout.new) do |c|
        c.content_region { "Content" }
        c.pane_region(tag: tag) { "Pane" }
      end

      assert_selector("div.PageLayout") do
        assert_selector("div.PageLayout-content", text: "Content")
        assert_selector("#{tag}.PageLayout-pane", text: "Pane")
      end
    end
  end

  def test_content_width
    Primer::Beta::SplitPageLayout::Content::WIDTH_OPTIONS.each do |width|
      render_inline(Primer::Beta::SplitPageLayout.new) do |c|
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

  def test_content_tags
    Primer::Beta::SplitPageLayout::Content::TAG_OPTIONS.each do |tag|
      render_inline(Primer::Beta::SplitPageLayout.new) do |c|
        c.content_region(tag: tag) { "Content" }
        c.pane_region { "Pane" }
      end

      assert_selector("div.PageLayout") do
        assert_selector("#{tag}.PageLayout-content", text: "Content")
        assert_selector("div.PageLayout-pane", text: "Pane")
      end
    end
  end
end
