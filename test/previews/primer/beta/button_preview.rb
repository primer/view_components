# frozen_string_literal: true

module Primer
  module Beta
    # @label Button
    class ButtonPreview < ViewComponent::Preview
      # @label Playground
      # @param scheme select [default, primary, danger, outline, invisible, link]
      # @param size select [small, medium, large]
      # @param full_width toggle
      # @param disabled toggle
      # @param pressed toggle
      # @param align_content select [center, start]
      # @param tag select [a, summary, button]
      def playground(
        scheme: :default,
        size: :medium,
        full_width: false,
        id: "button-preview",
        align_content: :center,
        tag: :button,
        disabled: false,
        pressed: false
      )
        render(Primer::Beta::Button.new(
                 scheme: scheme,
                 size: size,
                 full_width: full_width,
                 id: id,
                 align_content: align_content,
                 tag: tag,
                 disabled: disabled,
                 "aria-pressed": pressed
               )) do |_c|
          "Button"
        end
      end

      # @label With visuals
      # @param scheme select [default, primary, danger, outline, invisible, link]
      # @param size select [small, medium]
      # @param full_width toggle
      # @param align_content select [center, start]
      def with_visuals(
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
      end
  end
end
