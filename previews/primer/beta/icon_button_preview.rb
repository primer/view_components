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
      # @param tag select [a, summary, button]
      # @param icon [Symbol] octicon
      # @param show_tooltip toggle
      def playground(
        scheme: :default,
        size: :medium,
        id: "button-preview",
        tag: :button,
        disabled: false,
        icon: :plus,
        aria_label: "Button",
        show_tooltip: true
      )
        render(Primer::Beta::IconButton.new(
                 scheme: scheme,
                 size: size,
                 id: id,
                 tag: tag,
                 disabled: disabled,
                 icon: icon,
                 "aria-label": aria_label,
                 show_tooltip: show_tooltip
               ))
      end

      # @label Default
      # @param size select [small, medium, large]
      # @param aria_label text
      # @param disabled toggle
      # @param tag select [a, summary, button]
      # @snapshot
      def default(
        size: :medium,
        id: "button-preview",
        tag: :button,
        disabled: false,
        icon: :star,
        aria_label: "Button"
      )
        render(Primer::Beta::IconButton.new(
                 scheme: :default,
                 size: size,
                 id: id,
                 tag: tag,
                 disabled: disabled,
                 icon: icon,
                 "aria-label": aria_label
               ))
      end

      # @label Invisible
      # @param size select [small, medium, large]
      # @param aria_label text
      # @param disabled toggle
      # @param tag select [a, summary, button]
      # @snapshot
      def invisible(
        size: :medium,
        id: "button-preview",
        tag: :button,
        disabled: false,
        icon: :x,
        aria_label: "Button"
      )
        render(Primer::Beta::IconButton.new(
                 scheme: :invisible,
                 size: size,
                 id: id,
                 tag: tag,
                 disabled: disabled,
                 icon: icon,
                 "aria-label": aria_label
               ))
      end

      # @label Danger
      # @param size select [small, medium, large]
      # @param aria_label text
      # @param disabled toggle
      # @param tag select [a, summary, button]
      # @snapshot
      def danger(
        size: :medium,
        id: "button-preview",
        tag: :button,
        disabled: false,
        icon: :trash,
        aria_label: "Button"
      )
        render(Primer::Beta::IconButton.new(
                 scheme: :danger,
                 size: size,
                 id: id,
                 tag: tag,
                 disabled: disabled,
                 icon: icon,
                 "aria-label": aria_label
               ))
      end
    end
  end
end
