# frozen_string_literal: true

module Primer
  module Alpha
    # @label HiddenTextExpander
    class HiddenTextExpanderPreview < ViewComponent::Preview
      # @label Default options
      # @param label [String] text
      # @param inline [Boolean] toggle
      def default(label: "No effect", inline: false)
        render(Primer::Alpha::HiddenTextExpander.new(inline: inline, "aria-label": label))
      end
    end
  end
end
