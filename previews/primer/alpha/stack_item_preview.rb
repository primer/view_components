# frozen_string_literal: true

module Primer
  module Alpha
    # @label StackItem
    class StackItemPreview < ViewComponent::Preview
      # @label Default
      def default
      end

      # @label Playground
      #
      # @param tag text
      # @param grow toggle
      # @param grow_narrow toggle
      # @param grow_regular toggle
      # @param grow_wide toggle
      def playground(
        tag: Primer::Alpha::StackItem::DEFAULT_TAG,
        grow: Primer::Alpha::StackItem::GrowArg::DEFAULT,
        grow_narrow: Primer::Alpha::StackItem::GrowArg::DEFAULT,
        grow_regular: Primer::Alpha::StackItem::GrowArg::DEFAULT,
        grow_wide: Primer::Alpha::StackItem::GrowArg::DEFAULT
      )
        render_with_template(locals: {
          system_arguments: {
            tag: tag,
            grow: control_values_for(grow, grow_narrow, grow_regular, grow_wide)
          }
        })
      end

      private

      def control_values_for(normal, narrow, regular, wide)
        [narrow, regular, wide].any? ? { narrow: narrow, regular: regular, wide: wide} : normal
      end
    end
  end
end
