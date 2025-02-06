# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module OpenProject
    # @label Heading
    class HeadingPreview < ViewComponent::Preview
      # @label Playground
      # @param tag [Symbol] select [h1, h2, h3, h4, h5, h6]
      # @param content [String] text
      def playground(tag: :h2, content: "Heading")
        render(Primer::OpenProject::Heading.new(tag: tag)) { content }
      end

      # @label Default options
      #
      # @param tag [Symbol] select [h1, h2, h3, h4, h5, h6]
      # @param content [String] text
      # @snapshot
      def default(tag: :h2, content: "Heading")
        render(Primer::OpenProject::Heading.new(tag: tag)) { content }
      end
    end
  end
end
