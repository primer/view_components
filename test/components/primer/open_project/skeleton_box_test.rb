# frozen_string_literal: true

require "components/test_helper"

module Primer
  module OpenProject
    class SkeletonBoxTest < Minitest::Test
      include Primer::ComponentTestHelpers

      def test_renders_box_with_no_dimensions_by_default
        render_inline(Primer::OpenProject::SkeletonBox.new)

        assert_selector(".SkeletonBox") do |box|
          refute box[:style]
        end
      end

      def test_renders_box_with_width_only
        render_inline(Primer::OpenProject::SkeletonBox.new(width: "16px"))

        assert_selector(".SkeletonBox") do |box|
          assert_includes box[:style], "width: 16px"
          refute_includes box[:style], "height"
        end
      end

      def test_renders_box_with_height_only
        render_inline(Primer::OpenProject::SkeletonBox.new(height: "16px"))

        assert_selector(".SkeletonBox") do |box|
          assert_includes box[:style], "height: 16px"
          refute_includes box[:style], "width"
        end
      end

      def test_renders_box_with_both_dimensions
        render_inline(Primer::OpenProject::SkeletonBox.new(width: "16px", height: "16px"))

        assert_selector(".SkeletonBox") do |box|
          assert_includes box[:style], "width: 16px"
          assert_includes box[:style], "height: 16px"
        end
      end
    end
  end
end
