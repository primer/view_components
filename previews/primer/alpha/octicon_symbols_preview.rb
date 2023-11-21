# frozen_string_literal: true

module Primer
  module Alpha
    # @label OcticonSymbols
    class OcticonSymbolsPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param octicon [Symbol] medium_octicon
      def playground(octicon: :container)
        render_with_template(locals: { octicon: octicon })
      end

      # @label Default
      #
      # @snapshot
      def default
      end
    end
  end
end
