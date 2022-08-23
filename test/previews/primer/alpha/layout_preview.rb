# frozen_string_literal: true

module Primer
  module Alpha
    # @label Layout
    class LayoutPreview < ViewComponent::Preview
      # @label Default options
      # @param stacking_breakpoint [Symbol] select [sm, md, lg]
      # @param first_in_source [Symbol] select [sidebar, main]
      # @param gutter [Symbol] select [default, none, condensed, spacious]
      def default(stacking_breakpoint: :sm, gutter: :default, first_in_source: :sidebar)
        render(Primer::Alpha::Layout.new(stacking_breakpoint: stacking_breakpoint, gutter: gutter, first_in_source: first_in_source)) do |c|
          c.with_main(bg: :attention, p: 6) do
            "Main content"
          end
          c.with_sidebar(bg: :accent, p: 6) do
            "Sidebar content"
          end
        end
      end
    end
  end
end
