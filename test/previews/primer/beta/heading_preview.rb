# frozen_string_literal: true

module Primer
  module Beta
    # @label Heading
    class HeadingPreview < ViewComponent::Preview
      # @label Default options
      #
      # @param tag [Symbol] select [h1, h2, h3, h4, h5, h6]
      # @param content [String] text
      def default(tag: :h2, content: "Heading")
        render(Primer::Beta::Heading.new(tag: tag)) { content }
      end
    end
  end
end
