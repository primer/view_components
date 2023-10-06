# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module OpenProject
    # @label FlexLayout
    class FlexLayoutPreview < ViewComponent::Preview
      # @label Playground
      # @param direction [Symbol] select [column, column_reverse, row, row_reverse]
      # @param justify_content [Symbol] select [space_between, space_around, center, flex_start, flex_end]
      def playground(direction: :row, justify_content: :flex_start)
        render(Primer::OpenProject::FlexLayout.new(direction: direction, justify_content: justify_content)) do |component|
          component.with_box(bg: :attention, p: 6) do
            "Block 1"
          end
          component.with_box(bg: :accent, p: 6) do
            "Block 2"
          end
        end
      end

      # @label Default
      def default
        render(Primer::OpenProject::FlexLayout.new) do |component|
          component.with_column(bg: :attention, p: 6) do
            "Block 1"
          end
          component.with_column(bg: :accent, p: 6) do
            "Block 2"
          end
        end
      end

      # @label Row layout
      def row_layout
        render(Primer::OpenProject::FlexLayout.new) do |component|
          component.with_row(bg: :attention, p: 6) do
            "Block 1"
          end
          component.with_row(bg: :accent, p: 6) do
            "Block 2"
          end
        end
      end

      # @label Column layout
      def column_layout
        render(Primer::OpenProject::FlexLayout.new) do |component|
          component.with_column(bg: :attention, p: 6) do
            "Block 1"
          end
          component.with_column(bg: :accent, p: 6) do
            "Block 2"
          end
        end
      end

      # @label Nested layout
      def nested_layout
        render(Primer::OpenProject::FlexLayout.new) do |component|
          component.with_row(flex_layout: true) do |flex_child|
            flex_child.with_column(bg: :attention, p: 3) { "Block 1" }
            flex_child.with_column(bg: :success, p: 3) { "Block 2" }
          end

          component.with_row(bg: :accent, p: 6) { "Block 3" }
        end
      end
    end
  end
end
