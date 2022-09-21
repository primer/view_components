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

      def test_text_has_data_content_attribute
        render_preview(:default)

        assert_selector(".Button-label[data-content]")
      end

      def test_renders_icons_and_text
        render_preview(:icons_and_text)

        assert_selector("segmented-control ul.SegmentedControl") do
          assert_selector("button.Button", count: 3) do
            assert_selector(".Button-leadingVisual")
            assert_selector(".Button-label")
          end
        end
      end

      def test_renders_icons_only
        render_preview(:icons_only)

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
        render_preview(:full_width)

        assert_selector("segmented-control ul.SegmentedControl.SegmentedControl--fullWidth")
      end

      def test_renders_icons_only_when_narrow
        render_preview(:icons_only_when_narrow)

        assert_selector("segmented-control ul.SegmentedControl.SegmentedControl--iconOnly-whenNarrow")
      end
    end
  end
end
