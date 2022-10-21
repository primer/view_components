# frozen_string_literal: true

module Primer
  # @label LayoutComponent
  class LayoutComponentPreview < ViewComponent::Preview
    # @label Playground
    #
    # @param responsive [Boolean]
    # @param side [Symbol] select [left, right]
    # @param sidebar_col [Integer] select [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    def playground(responsive: false, side: :right, sidebar_col: 3)
      render(Primer::LayoutComponent.new(responsive: responsive, side: side, sidebar_col: sidebar_col)) do |component|
        component.with_main { "Main" }
        component.with_sidebar { "Sidebar" }
      end
    end

    # @label Default
    #
    # @param responsive [Boolean]
    # @param side [Symbol] select [left, right]
    # @param sidebar_col [Integer] select [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    def default(responsive: false, side: :right, sidebar_col: 3)
      render(Primer::LayoutComponent.new(responsive: responsive, side: side, sidebar_col: sidebar_col)) do |component|
        component.with_main { "Main" }
        component.with_sidebar { "Sidebar" }
      end
    end
  end
end
