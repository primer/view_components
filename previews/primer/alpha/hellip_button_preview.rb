# frozen_string_literal: true

module Primer
  module Alpha
    # @label HellipButton
    class HellipButtonPreview < ViewComponent::Preview
      # @label Default Options
      #
      # @param aria_label [String]
      # @param inline [Boolean]
      # @snapshot
      def default(inline: false, aria_label: "No effect")
        render(Primer::Alpha::HellipButton.new(inline: inline, "aria-label": aria_label))
      end

      # @label Playground
      #
      # @param aria_label [String]
      # @param inline [Boolean]
      # @param disabled [Boolean]
      def playground(inline: false, aria_label: "No effect", disabled: false)
        render(Primer::Alpha::HellipButton.new(inline: inline, "aria-label": aria_label, disabled: disabled))
      end
    end
  end
end
