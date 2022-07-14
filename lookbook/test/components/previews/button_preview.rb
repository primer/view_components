# frozen_string_literal: true

# @label Button
class ButtonPreview < ViewComponent::Preview
  # @label Playground
  # @param scheme select [default, primary, danger, outline, invisible, link]
  # @param size select [small, medium, large]
  # @param block toggle
  # @param disabled toggle
  # @param pressed toggle
  # @param dropdown toggle
  # @param align_content select [center, start]
  # @param tag select [a, summary, button]
  def playground(
    scheme: :default,
    size: :medium,
    block: false,
    dropdown: false,
    id: "button-preview",
    align_content: :center,
    tag: :button,
    disabled: false,
    pressed: false
  )
    render(Primer::ButtonComponent.new(
             scheme: scheme,
             size: size,
             block: block,
             dropdown: dropdown,
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
                         })
  end

    # @label Link as button
    # @param scheme select [default, primary, danger, outline, invisible, link]
    # @param size select [small, medium]
    # @param block toggle
    # @param dropdown toggle
    # @param align_content select [center, start]

    # def link_as_button(
    #   scheme: :default,
    #   size: :medium,
    #   block: false,
    #   dropdown: false,
    #   id: "button-preview",
    #   align_content: :center,
    #   tag: :a
    # )
    #   render(Primer::ButtonComponent.new(
    #            scheme: scheme,
    #            size: size,
    #            block: block,
    #            dropdown: dropdown,
    #            id: id,
    #            align_content: align_content,
    #            tag: tag
    #          )) do |_c|
    #     "Button"
    #   end
    # end
  end
