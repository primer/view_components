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
      # @param align_content select [center, start]
      # @param tag select [a, summary, button]
      def playground(
        scheme: :default,
        size: :medium,
        block: false,
        id: "button-preview",
        align_content: :center,
        tag: :button,
        disabled: false
      )
        render(Primer::Beta::Button.new(
                 scheme: scheme,
                 size: size,
                 block: block,
                 id: id,
                 align_content: align_content,
                 tag: tag,
                 disabled: disabled
               )) do |_c|
          "Button"
        end
      end

      # @label Default
      # @param block toggle
      # @param disabled toggle
      # @param tag select [a, summary, button]
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
      # @param tag select [a, summary, button]
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
      # @param tag select [a, summary, button]
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
      # @param tag select [a, summary, button]
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
      # @param tag select [a, summary, button]
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
      def all_schemes
        render_with_template(locals: {})
      end

      # @label Full width
      # @param disabled toggle
      # @param tag select [a, summary, button]
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

      # @label Link as button
      # @param scheme select [default, primary, danger, invisible, link]
      # @param size select [small, medium]
      # @param block toggle
      # @param align_content select [center, start]
      # @snapshot
      def link_as_button(
        scheme: :default,
        size: :medium,
        block: false,
        id: "button-preview",
        align_content: :center,
        tag: :a
      )
        render(Primer::Beta::Button.new(
                 scheme: scheme,
                 size: size,
                 block: block,
                 id: id,
                 align_content: align_content,
                 tag: tag
               )) do |_c|
          "Button"
        end
      end

      # @label Trailing visual
      # @param scheme select [default, primary, danger, invisible, link]
      # @param size select [small, medium]
      # @param block toggle
      # @param align_content select [center, start]
      # @param tag select [a, summary, button]
      # @snapshot
      def trailing_visual(
        scheme: :default,
        size: :medium,
        block: false,
        id: "button-preview",
        align_content: :center,
        tag: :a
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
    end
  end
end
