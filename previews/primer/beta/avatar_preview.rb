# frozen_string_literal: true

module Primer
  module Beta
    # @label Avatar
    class AvatarPreview < ViewComponent::Preview
      # @label Default options
      #
      # @param size [Integer] select [16, 20, 24, 32, 40, 48, 80]
      # @param shape [Symbol] select [circle, square]
      # @param href [String] text
      def default(size: 24, shape: :circle, href: nil)
        render(Primer::Beta::Avatar.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", size: size, shape: shape, href: href))
      end
    end
  end
end
