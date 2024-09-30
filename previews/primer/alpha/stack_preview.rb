# frozen_string_literal: true

module Primer
  module Alpha
    # @label Stack
    class StackPreview < ViewComponent::Preview
      # @label Playground
      #
      def playground()
        render(Primer::Alpha::Stack.new(justify: :center)) do |component|
            "Hello World!"
          end
      end
    end
  end
end