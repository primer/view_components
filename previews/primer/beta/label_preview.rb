# frozen_string_literal: true

module Primer
  module Beta
    # @label LabelComponent
    class LabelPreview < ViewComponent::Preview
      # @label Default Options
      #
      # @param size [Symbol] select [medium, large]
      # @param tag [Symbol] select [span, summary, a, div]
      # @param inline [Boolean] toggle
      def default(size: :medium, tag: :span, inline: false)
        render(Primer::Beta::Label.new(tag: tag, size: size, inline: inline)) { "Label" }
      end

      # @label Playground
      #
      # @param size [Symbol] select [medium, large]
      # @param tag [Symbol] select [span, summary, a, div]
      # @param inline [Boolean] toggle
      def playground(size: :medium, tag: :span, inline: false)
        render(Primer::Beta::Label.new(tag: tag, size: size, inline: inline)) { "Label" }
      end
    end
  end
end
