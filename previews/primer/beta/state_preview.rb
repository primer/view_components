# frozen_string_literal: true

module Primer
  module Beta
    # @label State
    class StateComponentPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param title [String]
      # @param tag [Symbol] select [span, div]
      # @param size [Symbol] select [default, small]
      # @param scheme [Symbol] select [default, open, closed, merged]
      def playground(title: "State", scheme: :default, size: :default, tag: :span)
        render(Primer::Beta::State.new(title: title, scheme: scheme, size: size, tag: tag)) { "State" }
      end

      # @label Default
      #
      # @param title [String]
      # @param tag [Symbol] select [span, div]
      # @param size [Symbol] select [default, small]
      # @param scheme [Symbol] select [default, open, closed, merged]
      def default(title: "State", scheme: :default, size: :default, tag: :span)
        render(Primer::Beta::State.new(title: title, scheme: scheme, size: size, tag: tag)) { "State" }
      end
    end
  end
end
