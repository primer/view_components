# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module OpenProject
    # @label CollapsibleBorderBox
    class CollapsibleBorderBoxPreview < ViewComponent::Preview
      # @label Playground
      # def playground(string_example: "Some value", boolean_example: false, select_example: :one)
      #   render(Primer::OpenProject::CollapsibleBorderBox.new(string_example: string_example, boolean_example: boolean_example, select_example: select_example))
      # end

      def default
        render(Primer::OpenProject::CollapsibleBorderBox.new(title: "Test", count: 2)) do |component|
          component.with_body { "Body" }
          component.with_row { "Row 1" }
          component.with_row { "Row 2" }
          component.with_row { "Row 3" }
          component.with_footer { "Footer" }
        end
      end
    end
  end
end
