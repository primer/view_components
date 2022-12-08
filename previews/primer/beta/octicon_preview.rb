# frozen_string_literal: true

module Primer
  module Beta
    # @label Octicon
    class OcticonPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param aria_label [String]
      # @param size [Symbol] select [xsmall, small, medium]
      def playground(size: :small, aria_label: nil)
        render(Primer::Beta::Octicon.new(icon: :people, size: size, "aria-label": aria_label))
      end

      # @label Default Options
      #
      # @param aria_label [String]
      # @param size [Symbol] select [xsmall, small, medium]
      def default(size: :small, aria_label: nil)
        render(Primer::Beta::Octicon.new(icon: :people, size: size, "aria-label": aria_label))
      end
    end
  end
end
