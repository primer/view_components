# frozen_string_literal: true

module Primer
  module OpenProject
    # @label SkeletonBox
    class SkeletonBoxPreview < ViewComponent::Preview
      # @label Default
      def default
        render(Primer::OpenProject::SkeletonBox.new(width: "64px", height: "64px"))
      end

      # @label Playground
      # @param width text
      # @param height text
      def playground(width: "64px", height: "64px")
        render(Primer::OpenProject::SkeletonBox.new(width: width, height: height))
      end
    end
  end
end
