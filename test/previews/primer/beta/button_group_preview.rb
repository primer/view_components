# frozen_string_literal: true

module Primer
  module Beta
    # @label ButtonGroup
    class ButtonGroupPreview < ViewComponent::Preview
      # @label Default options
      #
      # @param size [Symbol] select [medium, small]
      def default(size: :medium)
        render(Primer::Beta::ButtonGroup.new(size: size)) do |c|
          c.button { "Button" }
          c.button(scheme: :primary) { "Primary" }
          c.button(scheme: :danger) { "Danger" }
          c.button(scheme: :outline) { "Outline" }
        end
      end
    end
  end
end
