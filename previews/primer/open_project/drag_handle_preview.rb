# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module OpenProject
    # @label DragHandle
    class DragHandlePreview < ViewComponent::Preview
      # @label Default
      # @snapshot
      def default(size: :small)
        render(Primer::OpenProject::DragHandle.new(size: size))
      end

      # @label Playground
      # @param size [Symbol] select [xsmall, small, medium]
      def playground(size: :small)
        render(Primer::OpenProject::DragHandle.new(size: size))
      end
    end
  end
end
