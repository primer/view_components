# frozen_string_literal: true

module Primer
  module Beta
    # @label Button
    class ButtonPreview < ViewComponent::Preview
      # @label Playground
      # @param scheme select [default, primary, danger, invisible, link]
      # @param size select [small, medium, large]
      # @param full_width toggle
      # @param disabled toggle
      # @param align_content select [center, start]
      # @param tag select [a, summary, button]
      def playground(
        scheme: :default,
        size: :medium,
        full_width: false,
        id: "button-preview",
        align_content: :center,
        tag: :button,
        disabled: false
      )
        render(Primer::Beta::Button.new(
                 scheme: scheme,
                 size: size,
                 full_width: full_width,
                 id: id,
                 align_content: align_content,
                 tag: tag,
                 disabled: disabled
               )) do |_c|
          "Button"
        end
      end

      # @label Default
      # @param full_width toggle
      # @param disabled toggle
      # @param tag select [a, summary, button]
      def default(
        full_width: false,
        id: "button-preview",
        tag: :button,
        disabled: false
      )
        render(Primer::Beta::Button.new(
                 scheme: :default,
                 size: :medium,
                 full_width: full_width,
                 id: id,
                 tag: tag,
                 disabled: disabled
               )) do |_c|
          "Button"
        end
      end

      # @label Primary
      # @param full_width toggle
      # @param disabled toggle
      # @param tag select [a, summary, button]
      def primary(
        id: "button-preview",
        full_width: false,
        tag: :button,
        disabled: false
      )
        render(Primer::Beta::Button.new(
                 scheme: :primary,
                 size: :medium,
                 full_width: full_width,
                 id: id,
                 tag: tag,
                 disabled: disabled
               )) do |_c|
          "Button"
        end
      end

      # @label Danger
      # @param full_width toggle
      # @param disabled toggle
      # @param tag select [a, summary, button]
      def danger(
        id: "button-preview",
        full_width: false,
        tag: :button,
        disabled: false
      )
        render(Primer::Beta::Button.new(
                 scheme: :danger,
                 size: :medium,
                 full_width: full_width,
                 id: id,
                 tag: tag,
                 disabled: disabled
               )) do |_c|
          "Button"
        end
      end

      # @label Invisible
      # @param full_width toggle
      # @param disabled toggle
      # @param tag select [a, summary, button]
      def invisible(
        id: "button-preview",
        full_width: false,
        tag: :button,
        disabled: false
      )
        render(Primer::Beta::Button.new(
                 scheme: :invisible,
                 size: :medium,
                 full_width: full_width,
                 id: id,
                 tag: tag,
                 disabled: disabled
               )) do |_c|
          "Button"
        end
      end

      # @label All schemes
      def all_schemes
        render_with_template(locals: {})
      end

      # @label Full width
      # @param disabled toggle
      # @param tag select [a, summary, button]
      def full_width(
        id: "button-preview",
        tag: :button,
        disabled: false
      )
        render(Primer::Beta::Button.new(
                 scheme: :default,
                 size: :medium,
                 full_width: true,
                 id: id,
                 tag: tag,
                 disabled: disabled
               )) do |_c|
          "Button"
        end
      end

      # @label Link as button
      # @param scheme select [default, primary, danger, outline, invisible, link]
      # @param size select [small, medium]
      # @param full_width toggle
      # @param align_content select [center, start]
      def link_as_button(
        scheme: :default,
        size: :medium,
        full_width: false,
        id: "button-preview",
        align_content: :center,
        tag: :a
      )
        render(Primer::Beta::Button.new(
                 scheme: scheme,
                 size: size,
                 full_width: full_width,
                 id: id,
                 align_content: align_content,
                 tag: tag
               )) do |_c|
          "Button"
        end
      end

      # @label Trailing visual
      # @param scheme select [default, primary, danger, outline, invisible, link]
      # @param size select [small, medium]
      # @param full_width toggle
      # @param align_content select [center, start]
      # @param tag select [a, summary, button]
      def trailing_visual(
        scheme: :default,
        size: :medium,
        full_width: false,
        id: "button-preview",
        align_content: :center,
        tag: :a
      )
        render_with_template(locals: {
                               scheme: scheme,
                               size: size,
                               full_width: full_width,
                               id: id,
                               align_content: align_content,
                               tag: tag
                             })
      end

      # @label Leading visual
      # @param scheme select [default, primary, danger, outline, invisible, link]
      # @param size select [small, medium]
      # @param full_width toggle
      # @param align_content select [center, start]
      def leading_visual(
        scheme: :default,
        size: :medium,
        full_width: false,
        id: "button-preview",
        align_content: :center
      )
        render_with_template(locals: {
                               scheme: scheme,
                               size: size,
                               full_width: full_width,
                               id: id,
                               align_content: align_content
                             })
      end

      # @label Trailing action
      # @param full_width toggle
      # @param align_content select [center, start]
      def trailing_action(
        full_width: false,
        id: "button-preview",
        align_content: :center
      )
        render_with_template(locals: {
                               full_width: full_width,
                               id: id,
                               align_content: align_content
                             })
      end

      # @label With tooltip
      # @param scheme select [default, primary, danger, outline, invisible, link]
      # @param size select [small, medium]
      # @param full_width toggle
      # @param align_content select [center, start]
      def with_tooltip(
        scheme: :default,
        size: :medium,
        full_width: false,
        id: "button-preview",
        align_content: :center
      )
        render_with_template(locals: {
                               scheme: scheme,
                               size: size,
                               full_width: full_width,
                               id: id,
                               align_content: align_content
                             })
      end
    end
  end
end
