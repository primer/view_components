# frozen_string_literal: true

module Primer
  module Beta
    # @label Avatar
    class AvatarPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param size [Integer] select [16, 20, 24, 32, 40, 48, 80]
      # @param shape [Symbol] select [circle, square]
      # @param href [String] text
      def playground(size: 24, shape: :circle, href: nil)
        render(Primer::Beta::Avatar.new(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser", size: size, shape: shape, href: href))
      end

      # @label Default
      # @snapshot
      def default
        render(Primer::Beta::Avatar.new(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser"))
      end

      # @label As link
      #
      # @param href [String] text
      def as_link(href: "#")
        render(Primer::Beta::Avatar.new(href: href, src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser"))
      end

      # @!group Sizes
      #
      # @label 16px
      # @snapshot
      def size_16
        render(Primer::Beta::Avatar.new(size: 16, src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser"))
      end

      # @label 20px
      # @snapshot
      def size_20
        render(Primer::Beta::Avatar.new(size: 20, src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser"))
      end

      # @label 24px
      # @snapshot
      def size_24
        render(Primer::Beta::Avatar.new(size: 24, src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser"))
      end

      # @label 32px
      # @snapshot
      def size_32
        render(Primer::Beta::Avatar.new(size: 32, src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser"))
      end

      # @label 40px
      # @snapshot
      def size_40
        render(Primer::Beta::Avatar.new(size: 40, src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser"))
      end

      # @label 48px
      # @snapshot
      def size_48
        render(Primer::Beta::Avatar.new(size: 48, src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser"))
      end

      # @label 80px
      # @snapshot
      def size_80
        render(Primer::Beta::Avatar.new(size: 80, src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser"))
      end
      #
      # @!endgroup

      # @!group Shape
      #
      # @label Circle
      # @snapshot
      def shape_circle
        render(Primer::Beta::Avatar.new(shape: :circle, src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser"))
      end

      # @label Square
      # @snapshot
      def shape_square
        render(Primer::Beta::Avatar.new(shape: :square, src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser"))
      end
      #
      # @!endgroup
    end
  end
end
