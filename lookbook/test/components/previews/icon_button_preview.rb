# frozen_string_literal: true

# @label IconButton
class IconButtonPreview < ViewComponent::Preview
  # @label Playground
  # @param scheme select [default, danger]
  # @param size select [small, medium, large]
  # @param block toggle
  # @param aria_label text
  # @param disabled toggle
  # @param pressed toggle
  # @param dropdown toggle
  # @param align_content select [center, start]
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
    render(Primer::IconButton.new(
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
