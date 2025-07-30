# frozen_string_literal: true

module Primer
  module Alpha
    # @label SkeletonBox
    class SkeletonBoxPreview < ViewComponent::Preview
      # @label Default
      def default
        render(Primer::Alpha::SkeletonBox.new(width: "64px", height: "64px"))
      end

      # @label Playground
      # @param width text
      # @param height text
      def playground(width: "64px", height: "64px")
        render(Primer::Alpha::SkeletonBox.new(width: width, height: height))
      end
    end
  end
end
