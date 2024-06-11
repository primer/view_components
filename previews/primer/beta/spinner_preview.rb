# frozen_string_literal: true

module Primer
  module Beta
    # @label Spinner
    class SpinnerPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param size [Symbol] select [small, medium, large]
      def playground(size: :medium, sr_text: "Loading content...")
        render(Primer::Beta::Spinner.new(size: size, sr_text: sr_text))
      end

      # @label Default Options
      #
      # @param size [Symbol] select [small, medium, large]
      # @snapshot
      def default(size: :medium)
        render(Primer::Beta::Spinner.new(size: size))
      end
    end
  end
end
