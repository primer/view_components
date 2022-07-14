# frozen_string_literal: true

module Beta
  # @label Button
  class ButtonPreview < ViewComponent::Preview
    # @label Playground
    # @param scheme select [default, primary, danger, outline, invisible, link]
    # @param size select [small, medium]
    # @param block toggle
    # @param dropdown toggle
    # @param align_content select [center, start]
    def playground(
      scheme: :default,
      size: :medium,
      block: false,
      dropdown: false,
      id: "button-preview",
      align_content: :center
    )
      render(Primer::ButtonComponent.new(
               scheme: scheme,
               size: size,
               block: block,
               dropdown: dropdown,
               id: id,
               align_content: align_content
             )) do |_c|
        # c.leading_visual_icon(icon: :star)
        # c.trailing_visual_counter(count: 15)
        "Button"
      end
    end

    # def render_preview(content)
    #   render_with_template(
    #     locals: { content: content },
    #     template: "button/button_preview"
    #   )
    # end

    # @label With visuals
    # @param scheme select [default, primary, danger, outline, invisible, link]
    # @param size select [small, medium]
    # @param block toggle
    # @param dropdown toggle
    # @param align_content select [center, start]
    def with_visuals(
      scheme: :default,
      size: :medium,
      block: false,
      dropdown: false,
      id: "button-preview",
      align_content: :center
    )
      render_with_template(locals: {
                             scheme: scheme,
                             size: size,
                             block: block,
                             dropdown: dropdown,
                             id: id,
                             align_content: align_content
                           },
                           template: "button_preview/with_visuals")
    end
  end
end
