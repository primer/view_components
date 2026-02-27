# frozen_string_literal: true

module Primer
  module Beta
    # @label Truncate
    class TruncatePreview < ViewComponent::Preview
      # @label Playground
      #
      # @param text [String] text
      def playground(text: "branch-name-that-is-really-long")
        render(Primer::Beta::Truncate.new) { text }
      end

      # @label Default options
      #
      # @param text [String] text
      def default(text: "branch-name-that-is-really-long")
        render(Primer::Beta::Truncate.new) { text }
      end

      # @label Multiple items
      def multiple_items; end

      # @label Advanced multiple items
      def advanced_multiple_items; end

      # @label Max widths
      # @snapshot
      def max_widths; end
    end
  end
end
