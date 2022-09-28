# frozen_string_literal: true

module Primer
  module Beta
    # @label CloseButton
    class CloseButtonPreview < ViewComponent::Preview
      # @label Default options
      #
      # @param type [Symbol] select [button, submit]
      def default(type: :button)
        render(Primer::Beta::CloseButton.new(type: type))
      end
    end
  end
end
