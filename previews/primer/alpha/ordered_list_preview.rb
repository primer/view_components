# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module Alpha
    # @label OrderedList
    class OrderedListPreview < ViewComponent::Preview
      # @label Playground
      # @param type [Symbol] select [decimal, upper_alpha, lower_alpha, upper_roman, lower_roman]
      def playground(type: :lower_alpha)
        render(Primer::Alpha::OrderedList.new(type: type)) do |c|
          c.with_item { "Item 1" }
          c.with_item { "Item 2" }
          c.with_item { "Item 3" }
        end
      end

      # @label Decimal
      def decimal
        render(Primer::Alpha::OrderedList.new(type: :decimal)) do |c|
          c.with_item { "Item 1" }
          c.with_item { "Item 2" }
          c.with_item { "Item 3" }
        end
      end

      # @label Upper Alpha
      def upper_alpha
        render(Primer::Alpha::OrderedList.new(type: :upper_alpha)) do |c|
          c.with_item { "Item 1" }
          c.with_item { "Item 2" }
          c.with_item { "Item 3" }
        end
      end

      # @label Lower Alpha
      def lower_alpha
        render(Primer::Alpha::OrderedList.new(type: :lower_alpha)) do |c|
          c.with_item { "Item 1" }
          c.with_item { "Item 2" }
          c.with_item { "Item 3" }
        end
      end

      # @label Upper Roman
      def upper_roman
        render(Primer::Alpha::OrderedList.new(type: :upper_roman)) do |c|
          c.with_item { "Item 1" }
          c.with_item { "Item 2" }
          c.with_item { "Item 3" }
        end
      end

      # @label Lower Roman
      def lower_roman
        render(Primer::Alpha::OrderedList.new(type: :lower_roman)) do |c|
          c.with_item { "Item 1" }
          c.with_item { "Item 2" }
          c.with_item { "Item 3" }
        end
      end
    end
  end
end
