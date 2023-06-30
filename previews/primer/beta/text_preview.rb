# frozen_string_literal: true

module Primer
  module Beta
    # @label Text
    class TextPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param tag [Symbol] select [div, p, span]
      # @param content [String] text
      def playground(tag: :span, content: "Text")
        render(Primer::Beta::Text.new(tag: tag)) { content }
      end

      # @label Default options
      #
      # @param tag [Symbol] select [div, p, span]
      # @param content [String] text
      # @snapshot
      def default(tag: :span, content: "Text")
        render(Primer::Beta::Text.new(tag: tag)) { content }
      end
    end
  end
end
