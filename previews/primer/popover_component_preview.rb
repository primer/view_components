# frozen_string_literal: true

module Primer
  # @label PopoverComponent
  class PopoverComponentPreview < ViewComponent::Preview
    # @label Playground
    #
    # @param caret [Symbol] select [top, right, bottom, left, top_right, top_left, bottom_right, bottom_left, left_bottom, left_top, right_bottom, right_top]
    def playground(caret: :top)
      render Primer::PopoverComponent.new do |component|
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
    def default(caret: :top)
      render Primer::PopoverComponent.new do |component|
        component.with_heading do
          "Activity feed"
        end
        component.with_body(caret: caret) do
          "This is the Popover body."
        end
      end
    end
  end
end
