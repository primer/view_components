# frozen_string_literal: true

module Primer
  # @label HellipButton
  class HellipButtonPreview < ViewComponent::Preview
    # @label Default Options
    #
    # @param aria_label [String]
    # @param inline [Boolean]
    def default(inline: false, aria_label: "No effect")
      render(Primer::HellipButton.new(inline: inline, "aria-label": aria_label))
    end

    # @label Playground
    #
    # @param aria_label [String]
    # @param inline [Boolean]
    def playground(inline: false, aria_label: "No effect")
      render(Primer::HellipButton.new(inline: inline, "aria-label": aria_label))
    end
  end
end
