# frozen_string_literal: true

module Primer
  module Beta
    # @label BaseButton
    class BaseButtonPreview < ViewComponent::Preview
      # @label Default options
      #
      # @param type [Symbol] select [button, submit]
      # @param tag [Symbol] select [button, a, summary]
      # @param block [Boolean] toggle
      def default(tag: :button, block: false, type: :button)
        render(Primer::Beta::BaseButton.new(tag: tag, block: block, type: type)) { "Button" }
      end
    end
  end
end
