# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module OpenProject
    # @label GridLayout
    class GridLayoutPreview < ViewComponent::Preview
      # @label Playground
      def playground
        render(Primer::OpenProject::GridLayout.new(css_class: "grid-layout", tag: :div)) do |component|
          component.with_area(:area1, bg: :attention, p: 6) do
            "Block 1"
          end
          component.with_area(:area2, bg: :accent, p: 6) do
            "Block 2"
          end
        end
      end

      # The component can be used for easy layouting of multiple child components.
      # The component sets classes as well the grid-area definitions. The actual grid template can then be defined a separate CSS file.
      # @label Default
      def default
        render(Primer::OpenProject::GridLayout.new(css_class: "grid-layout", tag: :div)) do |component|
          component.with_area(:area1, bg: :attention, p: 6) do
            "Block 1"
          end
          component.with_area(:area2, bg: :accent, p: 6) do
            "Block 2"
          end
        end
      end
    end
  end
end
