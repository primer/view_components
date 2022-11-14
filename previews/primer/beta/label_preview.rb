# frozen_string_literal: true

module Primer
  module Beta
    # @label Label
    class LabelPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param size [Symbol] select [medium, large]
      # @param tag [Symbol] select [span, summary, a, div]
      # @param inline [Boolean] toggle
      def playground(size: :medium, tag: :span, inline: false)
        render(Primer::Beta::Label.new(tag: tag, size: size, inline: inline)) { "Label" }
      end

      # @label Default Options
      def default
        render(Primer::Beta::Label.new(tag: tag, size: size, inline: inline)) { "Label" }
      end
    end
  end
end
