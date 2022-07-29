# frozen_string_literal: true

require "test_helper"

module Primer
  module Alpha
    class SegmentedControlTest < Minitest::Test
      include Primer::ComponentTestHelpers
      include ViewComponent::RenderPreviewHelper

      def test_renders
        render_preview(:default)

        assert_selector("segmented-control.SegmentedControl") do
          assert_selector("button.SegmentedControl-button", count: Primer::Alpha::SegmentedControlPreview::NUMBER_OF_BUTTONS_DEFAULT) do
            assert_selector(".SegmentedControl-content") do
              refute_selector(".SegmentedControl-leadingVisual")
              assert_selector(".SegmentedControl-text")
            end
          end
        end
      end

      def test_selected_button_has_aria_attribute
        render_preview(:default)

        assert_selector("button.SegmentedControl-button.SegmentedControl-button--selected[aria-current=\"true\"]", count: 1)
      end

      def test_text_has_data_content_attribute
        render_preview(:default)

        assert_selector(".SegmentedControl-text[data-content]")
      end

      def test_renders_icons_and_text
        render_preview(:icons_and_text)

        assert_selector("segmented-control.SegmentedControl") do
          assert_selector("button.SegmentedControl-button", count: Primer::Alpha::SegmentedControlPreview::NUMBER_OF_BUTTONS_DEFAULT) do
            assert_selector(".SegmentedControl-content") do
              assert_selector(".SegmentedControl-leadingVisual")
              assert_selector(".SegmentedControl-text")
            end
          end
        end
      end

      def test_renders_icons_only
        render_preview(:icons_only)

        assert_selector("segmented-control.SegmentedControl") do
          assert_selector("button.SegmentedControl-button[id^=\"segmented-control-button-button-\"]", count: Primer::Alpha::SegmentedControlPreview::NUMBER_OF_BUTTONS_DEFAULT) do
            assert_selector(".SegmentedControl-content") do
              assert_selector(".SegmentedControl-leadingVisual")
              refute_selector(".SegmentedControl-text")
            end
            assert_selector("tool-tip[for^=\"segmented-control-button-button-\"]", visible: false)
          end
        end
      end

      def test_renders_full_width
        render_preview(:full_width)

        assert_selector("segmented-control.SegmentedControl.SegmentedControl--fullWidth")
      end

      def test_renders_icons_only_when_narrow
        render_preview(:icons_only_when_narrow)

        assert_selector("segmented-control.SegmentedControl.SegmentedControl--iconOnly-whenNarrow")
      end
    end
  end
end
