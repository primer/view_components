# frozen_string_literal: true

module Primer
  module Beta
    # @label Popover
    class PopoverPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param caret [Symbol] select [top, right, bottom, left, top_right, top_left, bottom_right, bottom_left, left_bottom, left_top, right_bottom, right_top]
      def playground(caret: :top)
        render Primer::Beta::Popover.new do |component|
          component.with_heading do
            "Activity feed"
          end
          component.with_body(caret: caret) do
            "This is the Popover body."
          end
        end
      end

      # @label Default
      #
      # @param caret [Symbol] select [top, right, bottom, left, top_right, top_left, bottom_right, bottom_left, left_bottom, left_top, right_bottom, right_top]
      # @snapshot
      def default(caret: :top)
        render Primer::Beta::Popover.new do |component|
          component.with_heading do
            "Activity feed"
          end
          component.with_body(caret: caret) do
            "This is the Popover body."
          end
        end
      end

      # @label Large
      # @snapshot
      def large
        render Primer::Beta::Popover.new do |component|
          component.with_body(large: true) do
            "This is a large Popover body."
          end
        end
      end

      # @!group Directions
      # @snapshot
      def bottom_right
        render Primer::Beta::Popover.new do |component|
          component.with_body(caret: :bottom_right) do
            "This is the Popover body."
          end
        end
      end

      # @snapshot
      def top_right
        render Primer::Beta::Popover.new do |component|
          component.with_body(caret: :top_right) do
            "This is the Popover body."
          end
        end
      end

      # @snapshot
      def bottom_left
        render Primer::Beta::Popover.new do |component|
          component.with_body(caret: :bottom_left) do
            "This is the Popover body."
          end
        end
      end

      # @snapshot
      def top_left
        render Primer::Beta::Popover.new do |component|
          component.with_body(caret: :top_left) do
            "This is the Popover body."
          end
        end
      end
      # @!endgroup
    end
  end
end
