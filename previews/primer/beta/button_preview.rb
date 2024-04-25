# frozen_string_literal: true

module Primer
  module Beta
    # @label Button
    class ButtonPreview < ViewComponent::Preview
      # Upgrade guide to Primer::Beta::Button
      #
      # | old param | new param | options |
      # | -- | -- | -- |
      # | variant | size | :small, :medium (default), :large |
      # | :outline | :default or :invisible | option for :scheme |
      # | dropdown | trailing action icon slot | see trailing action preview for markup |
      #

      # @label Playground
      # @param scheme select [default, primary, danger, invisible, link]
      # @param size select [small, medium, large]
      # @param block toggle
      # @param disabled toggle
      # @param inactive toggle
      # @param align_content select [center, start]
      # @param tag select [a, button]
      # @param label_wrap toggle
      def playground(
        scheme: :default,
        size: :medium,
        block: false,
        id: "button-preview",
        align_content: :center,
        tag: :button,
        disabled: false,
        inactive: false,
        label_wrap: false,
        href: nil
      )
        # Sets default href to `a`, to ensure it's keyboard interactive and proper markup
        if tag == :a && href.nil?
          href = "#"
        end
        render(Primer::Beta::Button.new(
                  scheme: scheme,
                  size: size,
                  block: block,
                  id: id,
                  align_content: align_content,
                  tag: tag,
                  disabled: disabled,
                  inactive: inactive,
                  label_wrap: label_wrap,
                  href: href
                )) do |_c|
          "Button"
        end
      end

      # @label Default
      # @param block toggle
      # @param disabled toggle
      def default(
        block: false,
        id: "button-preview",
        tag: :button,
        disabled: false
      )
        render(Primer::Beta::Button.new(
                 scheme: :default,
                 size: :medium,
                 block: block,
                 id: id,
                 tag: tag,
                 disabled: disabled
               )) do |_c|
          "Button"
        end
      end

      # @label Primary
      # @param block toggle
      # @param disabled toggle
      def primary(
        id: "button-preview",
        block: false,
        tag: :button,
        disabled: false
      )
        render(Primer::Beta::Button.new(
                 scheme: :primary,
                 size: :medium,
                 block: block,
                 id: id,
                 tag: tag,
                 disabled: disabled
               )) do |_c|
          "Button"
        end
      end

      # @label Danger
      # @param block toggle
      # @param disabled toggle
      def danger(
        id: "button-preview",
        block: false,
        tag: :button,
        disabled: false
      )
        render(Primer::Beta::Button.new(
                 scheme: :danger,
                 size: :medium,
                 block: block,
                 id: id,
                 tag: tag,
                 disabled: disabled
               )) do |_c|
          "Button"
        end
      end

      # @label Invisible
      # @param block toggle
      # @param disabled toggle
      def invisible(
        id: "button-preview",
        block: false,
        tag: :button,
        disabled: false
      )
        render(Primer::Beta::Button.new(
                 scheme: :invisible,
                 size: :medium,
                 block: block,
                 id: id,
                 tag: tag,
                 disabled: disabled
               )) do |_c|
          "Button"
        end
      end

      # @label Invisible all visuals
      # @snapshot
      def invisible_all_visuals
        render_with_template(locals: {})
      end

      # @label Link
      # @param block toggle
      # @param disabled toggle
      # @snapshot
      def link(
        id: "button-preview",
        block: false,
        tag: :button,
        disabled: false
      )
        render(Primer::Beta::Button.new(
                 scheme: :link,
                 size: :medium,
                 block: block,
                 id: id,
                 tag: tag,
                 disabled: disabled
               )) do |_c|
          "Button"
        end
      end

      # @label All schemes
      # @snapshot
      # @param disabled toggle
      def all_schemes(
        disabled: false
      )
        render_with_template(locals: {
                               disabled: disabled
                             })
      end

      # @label Full width
      # @param disabled toggle
      # @snapshot
      def full_width(
        id: "button-preview",
        tag: :button,
        disabled: false
      )
        render(Primer::Beta::Button.new(
                 scheme: :default,
                 size: :medium,
                 block: true,
                 id: id,
                 tag: tag,
                 disabled: disabled
               )) do |_c|
          "Button"
        end
      end

      # @label Label wrap
      # @param scheme select [default, primary, danger, invisible, link]
      # @param size select [small, medium]
      # @param block toggle
      # @param label_wrap toggle
      # @snapshot
      def label_wrap(
        scheme: :default,
        size: :medium,
        block: false,
        label_wrap: true
      )
        render_with_template(locals: {
                               scheme: scheme,
                               size: size,
                               block: block,
                               label_wrap: label_wrap
                             })
      end

      # @label Link as button
      # @param scheme select [default, primary, danger, invisible, link]
      # @param size select [small, medium]
      # @param block toggle
      # @param align_content select [center, start]
      # @param href
      # @snapshot
      def link_as_button(
        scheme: :default,
        size: :medium,
        block: false,
        id: "button-preview",
        align_content: :center,
        tag: :a,
        href: "#"
      )
        render(Primer::Beta::Button.new(
                 scheme: scheme,
                 size: size,
                 block: block,
                 id: id,
                 align_content: align_content,
                 tag: tag,
                 href: href
               )) do |_c|
          "Button"
        end
      end

      # @label Summary as button
      # @param scheme select [default, primary, danger, invisible, link]
      # @param size select [small, medium]
      # @param block toggle
      # @param align_content select [center, start]
      # @snapshot
      def summary_as_button(
        scheme: :default,
        size: :medium,
        block: false,
        id: "button-preview",
        align_content: :center,
        tag: :summary
      )
        render_with_template(locals: {
                              scheme: scheme,
                              size: size,
                              block: block,
                              id: id,
                              align_content: align_content,
                              tag: tag
                             })
      end

      # @label Trailing visual
      # @param scheme select [default, primary, danger, invisible, link]
      # @param size select [small, medium]
      # @param block toggle
      # @param align_content select [center, start]
      # @snapshot
      def trailing_visual(
        scheme: :default,
        size: :medium,
        block: false,
        id: "button-preview",
        align_content: :center,
        tag: :button
      )
        render_with_template(locals: {
                               scheme: scheme,
                               size: size,
                               block: block,
                               id: id,
                               align_content: align_content,
                               tag: tag
                             })
      end

      # @label Leading visual
      # @param scheme select [default, primary, danger, invisible, link]
      # @param size select [small, medium]
      # @param block toggle
      # @param align_content select [center, start]
      # @snapshot
      def leading_visual(
        scheme: :invisible,
        size: :medium,
        block: false,
        id: "button-preview",
        align_content: :center
      )
        render_with_template(locals: {
                               scheme: scheme,
                               size: size,
                               block: block,
                               id: id,
                               align_content: align_content
                             })
      end

      # @label Leading visual SVG
      # @param scheme select [default, primary, danger, invisible, link]
      # @param size select [small, medium]
      # @param block toggle
      # @param align_content select [center, start]
      # @snapshot
      def leading_visual_svg(
        scheme: :invisible,
        size: :medium,
        block: false,
        id: "button-preview",
        align_content: :center
      )
        render_with_template(locals: {
                               scheme: scheme,
                               size: size,
                               block: block,
                               id: id,
                               align_content: align_content
                             })
      end

      # @label Trailing action
      # @param block toggle
      # @param align_content select [center, start]
      # @snapshot
      def trailing_action(
        block: false,
        id: "button-preview",
        align_content: :center
      )
        render_with_template(locals: {
                               block: block,
                               id: id,
                               align_content: align_content
                             })
      end

      # @label Trailing Counter
      # @param block toggle
      # @param align_content select [center, start]
      # @param scheme select [default, primary, danger, invisible]
      # @snapshot
      def trailing_counter(
        block: false,
        id: "button-preview",
        align_content: :center,
        scheme: :primary
      )
        render_with_template(locals: {
                               block: block,
                               id: id,
                               align_content: align_content,
                               scheme: scheme
                             })
      end

      # @label With tooltip
      # @param scheme select [default, primary, danger, invisible, link]
      # @param size select [small, medium]
      # @param block toggle
      # @param align_content select [center, start]
      def with_tooltip(
        scheme: :default,
        size: :medium,
        block: false,
        id: "button-preview",
        align_content: :center
      )
        render_with_template(locals: {
                               scheme: scheme,
                               size: size,
                               block: block,
                               id: id,
                               align_content: align_content
                             })
      end

      # @label Inactive
      # @param inactive toggle
      # @snapshot
      def inactive(
        id: "button-preview",
        inactive: true
      )
        render(Primer::Beta::Button.new(
                 id: id,
                 inactive: inactive
               )) do |_c|
          "Button"
        end
      end

      # @label Link scheme with long label
      # @snapshot
      def link_scheme_label_wrap
        render_with_template(locals: {})
      end
    end
  end
end
