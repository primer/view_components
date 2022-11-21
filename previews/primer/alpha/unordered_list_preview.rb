# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module Alpha
    # @label UnorderedList
    class UnorderedListPreview < ViewComponent::Preview
      # @label Playground
      def playground
        render(Primer::Alpha::UnorderedList.new) do |c|
          c.with_item { "Item 1" }
          c.with_item { "Item 2" }
          c.with_item { "Item 3" }
        end
      end

      # @label Default options
      def default
        render(Primer::Alpha::UnorderedList.new) do |c|
          c.with_item { "Item 1" }
          c.with_item { "Item 2" }
          c.with_item { "Item 3" }
        end
      end
    end
  end
end
