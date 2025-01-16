# frozen_string_literal: true

module Primer
  module Beta
    # @label Heading
    class HeadingPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param tag [Symbol] select [h1, h2, h3, h4, h5, h6]
      # @param content [String] text
      def playground(tag: :h2, content: "Heading")
        render(Primer::Beta::Heading.new(tag: tag)) { content }
      end

      # @label Default options
      #
      # @param tag [Symbol] select [h1, h2, h3, h4, h5, h6]
      # @param content [String] text
      # @snapshot
      def default(tag: :h2, content: "Heading")
        render(Primer::Beta::Heading.new(tag: tag)) { content }
      end

            # @label Default options
      #
      # @param tag [Symbol] select [h1, h2, h3, h4, h5, h6]
      # @param content [String] text
      # @snapshot
      def temp(tag: :h2, content: "Blah blah test")
        render(Primer::Beta::Heading.new(tag: :h3)) { content }
      end
    end
  end
end
