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
      # @param inactive toggle
      # @param tag select [a, button]
      # @param icon [Symbol] octicon
      # @param show_tooltip toggle
      def playground(
        scheme: :default,
        size: :medium,
        id: "button-preview",
        tag: :button,
        disabled: false,
        inactive: false,
        icon: :plus,
        aria_label: "Button",
        show_tooltip: true,
        href: nil
      )
        # Sets default href to `a`, to ensure it's keyboard interactive and proper markup
        if tag == :a && href.nil?
          href = "#"
        end
        render(Primer::Beta::IconButton.new(
                 scheme: scheme,
                 size: size,
                 id: id,
                 tag: tag,
                 disabled: disabled,
                 inactive: inactive,
                 icon: icon,
                 "aria-label": aria_label,
                 show_tooltip: show_tooltip,
                 href: href
               ))
      end

      # @label Default
      # @param size select [small, medium, large]
      # @param aria_label text
      # @param disabled toggle
      # @param tag select [a, button]
      # @snapshot
      def default(
        size: :medium,
        id: "button-preview",
        tag: :button,
        disabled: false,
        icon: :star,
        aria_label: "Button",
        href: nil
      )
        # Sets default href to `a`, to ensure it's keyboard interactive and proper markup
        if tag == :a && href.nil?
          href = "#"
        end
        render(Primer::Beta::IconButton.new(
                 scheme: :default,
                 size: size,
                 id: id,
                 tag: tag,
                 disabled: disabled,
                 icon: icon,
                 "aria-label": aria_label,
                 href: href
               ))
      end

      # @label Invisible
      # @param size select [small, medium, large]
      # @param aria_label text
      # @param disabled toggle
      # @param tag select [a, button]
      # @snapshot
      def invisible(
        size: :medium,
        id: "button-preview",
        tag: :button,
        disabled: false,
        icon: :x,
        aria_label: "Button",
        href: nil
      )
        # Sets default href to `a`, to ensure it's keyboard interactive and proper markup
        if tag == :a && href.nil?
          href = "#"
        end
        render(Primer::Beta::IconButton.new(
                 scheme: :invisible,
                 size: size,
                 id: id,
                 tag: tag,
                 disabled: disabled,
                 icon: icon,
                 "aria-label": aria_label,
                 href: href
               ))
      end

      # @label Primary
      # @param size select [small, medium, large]
      # @param aria_label text
      # @param disabled toggle
      # @param tag select [a, button]
      # @snapshot
      def primary(
        size: :medium,
        id: "button-preview",
        tag: :button,
        disabled: false,
        icon: :x,
        aria_label: "Button",
        href: nil
      )
        # Sets default href to `a`, to ensure it's keyboard interactive and proper markup
        if tag == :a && href.nil?
          href = "#"
        end
        render(Primer::Beta::IconButton.new(
                 scheme: :primary,
                 size: size,
                 id: id,
                 tag: tag,
                 disabled: disabled,
                 icon: icon,
                 "aria-label": aria_label,
                 href: href
               ))
      end

      # @label Danger
      # @param size select [small, medium, large]
      # @param aria_label text
      # @param disabled toggle
      # @param tag select [a, button]
      # @snapshot
      def danger(
        size: :medium,
        id: "button-preview",
        tag: :button,
        disabled: false,
        icon: :trash,
        aria_label: "Button",
        href: nil
      )
        # Sets default href to `a`, to ensure it's keyboard interactive and proper markup
        if tag == :a && href.nil?
          href = "#"
        end
        render(Primer::Beta::IconButton.new(
                 scheme: :danger,
                 size: size,
                 id: id,
                 tag: tag,
                 disabled: disabled,
                 icon: icon,
                 "aria-label": aria_label,
                 href: href
               ))
      end

      # @label Link as button
      # @param size select [small, medium, large]
      # @param aria_label text
      # @param disabled toggle
      # @param href text
      # @snapshot
      def link_as_button(
        size: :medium,
        id: "button-preview",
        tag: :a,
        href: "#",
        disabled: false,
        icon: :star,
        aria_label: "Link"
      )
        render(Primer::Beta::IconButton.new(
                 scheme: :default,
                 size: size,
                 id: id,
                 tag: tag,
                 href: href,
                 disabled: disabled,
                 icon: icon,
                 "aria-label": aria_label
               ))
      end

      # @label Summary as button
      # @param size select [small, medium, large]
      # @param aria_label text
      # @param disabled toggle
      # @snapshot
      def summary_as_button(
        size: :medium,
        id: "button-preview",
        tag: :summary,
        disabled: false,
        icon: :star,
        aria_label: "Button"
      )
        render_with_template(locals: {
                              scheme: :default,
                              size: size,
                              id: id,
                              tag: tag,
                              disabled: disabled,
                              icon: icon,
                              "aria-label": aria_label
                             })
      end
    end
  end
end
