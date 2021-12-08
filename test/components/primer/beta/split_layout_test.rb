# frozen_string_literal: true

require "test_helper"

class PrimerBetaSplitLayoutTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_doesnt_render_without_both_slots
    render_inline(Primer::Beta::SplitLayout.new)
    refute_component_rendered

    render_inline(Primer::Beta::SplitLayout.new) { |c| c.main { "Main" } }
    refute_component_rendered

    render_inline(Primer::Beta::SplitLayout.new) { |c| c.pane { "Pane" } }
    refute_component_rendered
  end

  def test_renders_layout
    render_inline(Primer::Beta::SplitLayout.new) do |c|
      c.main { "Main" }
      c.pane { "Pane" }
    end

    assert_selector("div.LayoutBeta") do
      assert_selector("div.LayoutBeta-content", text: "Main")
      assert_selector("div.LayoutBeta-pane", text: "Pane")
    end
  end

  def test_renders_layout_with_correct_default_classes
    render_inline(Primer::Beta::SplitLayout.new) do |c|
      c.main { "Main" }
      c.pane { "Pane" }
    end

    expected_classes = [
      "LayoutBeta",
      "LayoutBeta--variant-separateRegions",
      "LayoutBeta--variant-md-multiColumns",
      "LayoutBeta--primary-content",
      "LayoutBeta--inner-spacing-normal",
      "LayoutBeta--column-gap-none",
      "LayoutBeta--row-gap-none",
      "LayoutBeta--pane-position-start",
      "LayoutBeta--pane-divider"
    ].join(".")
    assert_selector("div.#{expected_classes}") do
      assert_selector("div.LayoutBeta-content", text: "Main")
      assert_selector("div.LayoutBeta-pane", text: "Pane")
    end
  end

  def test_responsive_primary_region
    Primer::Beta::SplitLayout::RESPONSIVE_PRIMARY_REGION_OPTIONS.each do |region|
      render_inline(Primer::Beta::SplitLayout.new(responsive_primary_region: region)) do |c|
        c.main { "Main" }
        c.pane { "Pane" }
      end

      region_class = Primer::Beta::SplitLayout::RESPONSIVE_PRIMARY_REGION_MAPPINGS[region]
      assert_selector("div.LayoutBeta#{region_class.empty? ? '' : ".#{region_class}"}") do
        assert_selector("div.LayoutBeta-content", text: "Main")
        assert_selector("div.LayoutBeta-pane", text: "Pane")
      end
    end
  end

  def test_pane_width
    Primer::Beta::SplitLayout::PANE_WIDTH_OPTIONS.each do |size|
      render_inline(Primer::Beta::SplitLayout.new) do |c|
        c.main { "Main" }
        c.pane(width: size) { "Pane" }
      end

      width_class = Primer::Beta::SplitLayout::PANE_WIDTH_MAPPINGS[size]
      assert_selector("div.LayoutBeta") do
        assert_selector("div#{width_class.empty? ? '' : ".#{width_class}"}") do
          assert_selector("div.LayoutBeta-content", text: "Main")
          assert_selector("div.LayoutBeta-pane", text: "Pane")
        end
      end
    end
  end

  def test_pane_tags
    Primer::Beta::SplitLayout::PANE_TAG_OPTIONS.each do |tag|
      render_inline(Primer::Beta::SplitLayout.new) do |c|
        c.main { "Main" }
        c.pane(tag: tag) { "Pane" }
      end

      assert_selector("div.LayoutBeta") do
        assert_selector("div.LayoutBeta-content", text: "Main")
        assert_selector("#{tag}.LayoutBeta-pane", text: "Pane")
      end
    end
  end

  def test_main_width
    Primer::Beta::SplitLayout::Main::WIDTH_OPTIONS.each do |width|
      render_inline(Primer::Beta::SplitLayout.new) do |c|
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
end
