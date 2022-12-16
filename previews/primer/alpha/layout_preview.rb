# frozen_string_literal: true

module Primer
  module Alpha
    # @label Layout
    class LayoutPreview < ViewComponent::Preview
      # @label Playground
      # @param stacking_breakpoint [Symbol] select [sm, md, lg]
      # @param first_in_source [Symbol] select [sidebar, main]
      # @param gutter [Symbol] select [default, none, condensed, spacious]
      def playground(stacking_breakpoint: :sm, gutter: :default, first_in_source: :sidebar)
        render(Primer::Alpha::Layout.new(stacking_breakpoint: stacking_breakpoint, gutter: gutter, first_in_source: first_in_source)) do |component|
          component.with_main(bg: :attention, p: 6) do
            "Main content"
          end
          component.with_sidebar(bg: :accent, p: 6) do
            "Sidebar content"
          end
        end
      end

      # @label Default
      def default
        render(Primer::Alpha::Layout.new) do |component|
          component.with_main(bg: :attention, p: 6) do
            "Main content"
          end
          component.with_sidebar(bg: :accent, p: 6) do
            "Sidebar content"
          end
        end
      end

      # @!group Gutter
      #
      # @label None
      def gutter_none
        render(Primer::Alpha::Layout.new(gutter: :none)) do |component|
          component.with_main(bg: :attention, p: 6) { "Main content" }
          component.with_sidebar(bg: :accent, p: 6) { "Sidebar content" }
        end
      end

      # @label Condensed
      def gutter_condensed
        render(Primer::Alpha::Layout.new(gutter: :condensed)) do |component|
          component.with_main(bg: :attention, p: 6) { "Main content" }
          component.with_sidebar(bg: :accent, p: 6) { "Sidebar content" }
        end
      end

      # @label Default
      def gutter_default
        render(Primer::Alpha::Layout.new(gutter: :default)) do |component|
          component.with_main(bg: :attention, p: 6) { "Main content" }
          component.with_sidebar(bg: :accent, p: 6) { "Sidebar content" }
        end
      end

      # @label Spacious
      def gutter_spacious
        render(Primer::Alpha::Layout.new(gutter: :spacious)) do |component|
          component.with_main(bg: :attention, p: 6) { "Main content" }
          component.with_sidebar(bg: :accent, p: 6) { "Sidebar content" }
        end
      end
      #
      # @!endgroup

      # @!group Main width
      #
      # @label Medium
      def main_width_md
        render(Primer::Alpha::Layout.new) do |component|
          component.with_main(width: :md, bg: :attention, p: 6) { "Main content" }
          component.with_sidebar(bg: :accent, p: 6) { "Sidebar content" }
        end
      end

      # @label Large
      def main_width_lg
        render(Primer::Alpha::Layout.new) do |component|
          component.with_main(width: :lg, bg: :attention, p: 6) { "Main content" }
          component.with_sidebar(bg: :accent, p: 6) { "Sidebar content" }
        end
      end

      # @label Extra large
      def main_width_xl
        render(Primer::Alpha::Layout.new) do |component|
          component.with_main(width: :xl, bg: :attention, p: 6) { "Main content" }
          component.with_sidebar(bg: :accent, p: 6) { "Sidebar content" }
        end
      end

      # @label Full
      def main_width_full
        render(Primer::Alpha::Layout.new) do |component|
          component.with_main(width: :full, bg: :attention, p: 6) { "Main content" }
          component.with_sidebar(bg: :accent, p: 6) { "Sidebar content" }
        end
      end
      #
      # @!endgroup

      # @!group Sidebar width
      #
      # @label Narrow
      def sidebar_width_narrow
        render(Primer::Alpha::Layout.new) do |component|
          component.with_main(bg: :attention, p: 6) { "Main content" }
          component.with_sidebar(width: :narrow, bg: :accent, p: 6) { "Sidebar content" }
        end
      end

      # @label Default
      def sidebar_width_default
        render(Primer::Alpha::Layout.new) do |component|
          component.with_main(bg: :attention, p: 6) { "Main content" }
          component.with_sidebar(width: :default, bg: :accent, p: 6) { "Sidebar content" }
        end
      end

      # @label Wide
      def sidebar_width_wide
        render(Primer::Alpha::Layout.new) do |component|
          component.with_main(bg: :attention, p: 6) { "Main content" }
          component.with_sidebar(width: :wide, bg: :accent, p: 6) { "Sidebar content" }
        end
      end
      #
      # @!endgroup

      # @!group Sidebar column placement
      #
      # @label Start
      def sidebar_col_placement_start
        render(Primer::Alpha::Layout.new) do |component|
          component.with_main(bg: :attention, p: 6) { "Main content" }
          component.with_sidebar(col_placement: :start, bg: :accent, p: 6) { "Sidebar content" }
        end
      end

      # @label End
      def sidebar_col_placement_end
        render(Primer::Alpha::Layout.new) do |component|
          component.with_main(bg: :attention, p: 6) { "Main content" }
          component.with_sidebar(col_placement: :end, bg: :accent, p: 6) { "Sidebar content" }
        end
      end
      #
      # @!endgroup

      # @!group Sidebar row placement
      #
      # @label Start
      def sidebar_row_placement_start
        render(Primer::Alpha::Layout.new) do |component|
          component.with_main(bg: :attention, p: 6) { "Main content" }
          component.with_sidebar(row_placement: :start, bg: :accent, p: 6) { "Sidebar content" }
        end
      end

      # @label End
      def sidebar_row_placement_end
        render(Primer::Alpha::Layout.new) do |component|
          component.with_main(bg: :attention, p: 6) { "Main content" }
          component.with_sidebar(row_placement: :end, bg: :accent, p: 6) { "Sidebar content" }
        end
      end

      # @label None
      def sidebar_row_placement_none
        render(Primer::Alpha::Layout.new) do |component|
          component.with_main(bg: :attention, p: 6) { "Main content" }
          component.with_sidebar(row_placement: :none, bg: :accent, p: 6) { "Sidebar content" }
        end
      end
      #
      # @!endgroup

      # @!group Stacking breakpoint
      #
      # @label Small
      def stacking_breakpoint_sm
        render(Primer::Alpha::Layout.new(stacking_breakpoint: :sm)) do |component|
          component.with_main(bg: :attention, p: 6) { "Main content" }
          component.with_sidebar(bg: :accent, p: 6) { "Sidebar content" }
        end
      end

      # @label Medium
      def stacking_breakpoint_md
        render(Primer::Alpha::Layout.new(stacking_breakpoint: :md)) do |component|
          component.with_main(bg: :attention, p: 6) { "Main content" }
          component.with_sidebar(bg: :accent, p: 6) { "Sidebar content" }
        end
      end

      # @label Large
      def stacking_breakpoint_lg
        render(Primer::Alpha::Layout.new(stacking_breakpoint: :lg)) do |component|
          component.with_main(bg: :attention, p: 6) { "Main content" }
          component.with_sidebar(bg: :accent, p: 6) { "Sidebar content" }
        end
      end
      #
      # @!endgroup
    end
  end
end
