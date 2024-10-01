# frozen_string_literal: true

module Primer
  module Alpha
    # @label Stack
    class StackPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param tag text
      # @param justify [Symbol] select [start, center, end, space_between, space_evenly]
      # @param gap [Symbol] select [condensed, normal, spacious]
      # @param direction [Symbol] select [vertical, horizontal]
      # @param align [Symbol] select [stretch, start, center, end, baseline]
      # @param wrap [Symbol] select [nowrap, wrap]
      # @param padding [Symbol] select [none, condensed, normal, spacious]
      def playground(
        tag: :div,
        justify: :start,
        gap: nil,
        direction: :vertical,
        align: :stretch,
        wrap: :nowrap,
        padding: :none
      )
        render(
          Primer::Alpha::Stack.new(
            tag: tag,
            justify: justify,
            gap: gap,
            direction: direction,
            wrap: wrap,
            padding: padding,
            align: align,
            border: true,
            border_color: :success_emphasis
        )) do
          "Hello World!"
        end
      end
    end
  end
end
