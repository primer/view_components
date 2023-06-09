# frozen_string_literal: true

module Primer
  module Beta
    # @label CloseButton
    class CloseButtonPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param type [Symbol] select [button, submit]
      # @param disabled toggle
      def playground(type: :button, disabled: false)
        render(Primer::Beta::CloseButton.new(type: type, disabled: disabled))
      end

      # @label Default options
      #
      # @param type [Symbol] select [button, submit]
      def default(type: :button)
        render(Primer::Beta::CloseButton.new(type: type))
      end
    end
  end
end
