# frozen_string_literal: true

# no doc
class AvatarStackPreview < ViewComponent::Preview
  # @label Rounded
  #
  # @param body_label [String] text
  def default(body_label: "This is a tooltip!")
    render(Primer::Beta::AvatarStack.new(tooltipped: true, body_arguments: { label: body_label })) do |c|
      c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser")
      c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser")
      c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser")
    end
  end
end
