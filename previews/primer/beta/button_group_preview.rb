# frozen_string_literal: true

module Primer
  module Beta
    # @label ButtonGroup
    class ButtonGroupPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param size [Symbol] select [medium, small]
      def playground(size: :medium)
        render(Primer::Beta::ButtonGroup.new(size: size)) do |component|
          component.with_button { "Button" }
          component.with_button(scheme: :primary) { "Primary" }
          component.with_button(scheme: :danger) { "Danger" }
          component.with_button(scheme: :outline) { "Outline" }
        end
      end

      # @label Default options
      #
      # @param size [Symbol] select [medium, small]
      def default(size: :medium)
        render(Primer::Beta::ButtonGroup.new(size: size)) do |component|
          component.with_button { "Button" }
          component.with_button(scheme: :primary) { "Primary" }
          component.with_button(scheme: :danger) { "Danger" }
          component.with_button(scheme: :outline) { "Outline" }
        end
      end
    end
  end
end
