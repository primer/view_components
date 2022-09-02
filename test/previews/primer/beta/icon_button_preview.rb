# frozen_string_literal: true

module Primer
  module Beta
    # @label IconButton
    class IconButtonPreview < ViewComponent::Preview
      # @label Playground
      # @param scheme select [default, danger, invisible]
      # @param size select [small, medium, large]
      # @param aria_label text
      # @param disabled toggle
      # @param pressed toggle
      # @param tag select [a, summary, button]
      def playground(
        scheme: :default,
        size: :medium,
        id: "button-preview",
        tag: :button,
        disabled: false,
        icon: :star,
        aria_label: "Button"
      )
        render(Primer::Beta::IconButton.new(
                 scheme: scheme,
                 size: size,
                 id: id,
                 tag: tag,
                 disabled: disabled,
                 icon: icon,
                 "aria-label": aria_label
               )) do |_c|
          "Button"
        end
      end
    end
  end
end
