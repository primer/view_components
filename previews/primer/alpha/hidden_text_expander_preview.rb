# frozen_string_literal: true

module Primer
  module Alpha
    # @label HiddenTextExpander
    class HiddenTextExpanderPreview < ViewComponent::Preview
      # @label Playground
      # @param label [String] text
      # @param inline [Boolean] toggle
      def playground(label: "No effect", inline: false)
        render(Primer::Alpha::HiddenTextExpander.new(inline: inline, "aria-label": label))
      end

      # @label Default options
      # @param label [String] text
      # @param inline [Boolean] toggle
      # @snapshot
      def default(label: "No effect", inline: false)
        render(Primer::Alpha::HiddenTextExpander.new(inline: inline, "aria-label": label))
      end
    end
  end
end
