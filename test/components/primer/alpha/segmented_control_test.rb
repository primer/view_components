# frozen_string_literal: true

require "test_helper"

module Primer
  module Alpha
    class SegmentedControlTest < Minitest::Test
      include Primer::ComponentTestHelpers

      def test_renders
        render_preview(:default)

        assert_selector("segmented-control ul.SegmentedControl") do
          assert_selector("li button.Button", count: 3)
        end
      end

      def test_selected_button_has_aria_attribute
        render_preview(:default)

        assert_selector("button.Button[aria-current=\"true\"]", count: 1)
      end

      def test_renders_icons_and_text
        render_preview(:icons_and_text_medium)

        assert_selector("segmented-control ul.SegmentedControl") do
          assert_selector("button.Button", count: 3) do
            assert_selector(".Button-leadingVisual")
            assert_selector(".Button-label")
          end
        end
      end

      def test_renders_icons_only
        render_preview(:icon_only_medium)

        assert_selector("segmented-control ul.SegmentedControl") do
          assert_selector(".Button-withTooltip", count: 3) do
            assert_selector("button.Button[id^=\"icon-button-\"]") do
              assert_selector(".Button-visual")
            end
            assert_selector("tool-tip[for^=\"icon-button-\"]", visible: false)
          end
        end
      end

      def test_renders_full_width
        render_preview(:full_width_small)

        assert_selector("segmented-control ul.SegmentedControl.SegmentedControl--fullWidth")
      end

      def test_doesnt_use_control_click_with_href
        render_inline(Primer::Alpha::SegmentedControl.new("aria-label": "File view")) do |component|
          component.with_item(icon: :zap, label: "Item 1", selected: true) { "Item 1" }
          component.with_item(tag: :a, href: "#", icon: :zap, label: "Item 2") { "Item 2" }
        end

        assert_selector("button[data-action=\"click:segmented-control#select\"]", count: 1)
        assert_selector("a[data-action=\"click:segmented-control#select\"]", count: 0)
      end

      def test_doesnt_render_with_too_many_items
        error = assert_raises(ArgumentError) do
          render_inline(Primer::Alpha::SegmentedControl.new("aria-label": "File view")) do |component|
            component.with_item(label: "Item 1", selected: true) { "Item 1" }
            component.with_item(label: "Item 2") { "Item 2" }
            component.with_item(label: "Item 3") { "Item 3" }
            component.with_item(label: "Item 4") { "Item 4" }
            component.with_item(label: "Item 5") { "Item 5" }
            component.with_item(label: "Item 6") { "Item 6" }
          end
        end

        assert_equal(error.message, "A segmented control should have 2–5 choices with text labels, or up to 6 icon-only buttons.")
      end

      def test_doesnt_render_with_too_many_icon_items
        error = assert_raises(ArgumentError) do
          render_inline(Primer::Alpha::SegmentedControl.new(hide_labels: true, "aria-label": "File view")) do |component|
            component.with_item(icon: :zap, label: "Item 1", selected: true) { "Item 1" }
            component.with_item(icon: :zap, label: "Item 2") { "Item 2" }
            component.with_item(icon: :zap, label: "Item 3") { "Item 3" }
            component.with_item(icon: :zap, label: "Item 4") { "Item 4" }
            component.with_item(icon: :zap, label: "Item 5") { "Item 5" }
            component.with_item(icon: :zap, label: "Item 6") { "Item 6" }
            component.with_item(icon: :zap, label: "Item 7") { "Item 7" }
          end
        end

        assert_equal(error.message, "A segmented control should have 2–5 choices with text labels, or up to 6 icon-only buttons.")
      end

      def test_raises_if_no_aria_label_is_provided
        err = assert_raises ArgumentError do
          render_inline(Primer::Alpha::SegmentedControl.new)
        end

        assert_equal("`aria-label`, `aria-labelledby` or `aria-describedby` is required.", err.message)
      end
    end
  end
end
