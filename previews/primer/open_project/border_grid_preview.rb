# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module OpenProject
    # @label BorderGrid
    class BorderGridPreview < ViewComponent::Preview

      # @label Playground
      # @param spacious [Boolean] toggle
      def playground(spacious: false)
        render(Primer::OpenProject::BorderGrid.new(spacious: spacious)) do |grid|
          grid.with_row { "Block 1" }
          grid.with_row { "Block 2" }
          grid.with_row { "Block 3" }
        end
      end

      # @label Default Options
      #
      # @snapshot
      def default()
        render(Primer::OpenProject::BorderGrid.new) do |grid|
          grid.with_row { "Block 1" }
          grid.with_row { "Block 2" }
          grid.with_row { "Block 3" }
        end
      end

      # @label Spacious
      def spacious()
        render(Primer::OpenProject::BorderGrid.new(spacious: true)) do |grid|
          grid.with_row { "Block 1" }
          grid.with_row { "Block 2" }
          grid.with_row { "Block 3" }
        end
      end
    end
  end
end
