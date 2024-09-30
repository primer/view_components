# frozen_string_literal: true

module Primer
  module Alpha
    # @label StackItem
    class StackItemPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param grow toggle
      def playground(grow: false)
        render_with_template(locals: {
          system_arguments: {
            grow: grow
          }
        })
      end
    end
  end
end
