# frozen_string_literal: true

module Primer
  module Beta
    # @label AvatarStack
    class AvatarStackPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param number_of_avatars [Integer] number
      # @param tag select [["div", div], ["span", span]]
      # @param align select [["Left", left], ["Right", right]]
      # @param tooltipped toggle
      # @param tooltip_label text
      # @param disable_expand toggle
      def playground(number_of_avatars: 1, tag: :div, align: :left, tooltipped: false, tooltip_label: "This is a tooltip!", disable_expand: false)
        render(Primer::Beta::AvatarStack.new(tag: tag, align: align, tooltipped: tooltipped, disable_expand: disable_expand, body_arguments: { label: tooltip_label })) do |component|
          Array.new(number_of_avatars&.to_i || 1) do
            component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          end
        end
      end

      # @label Default
      # @snapshot
      def default
        render(Primer::Beta::AvatarStack.new) do |component|
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
        end
      end

      # @!group Multiple avatars
      #
      # @label 1 avatar
      def avatar_1
        render(Primer::Beta::AvatarStack.new) do |component|
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
        end
      end

      # @label 2 avatars
      # @snapshot
      def avatar_2
        render(Primer::Beta::AvatarStack.new) do |component|
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
        end
      end

      # @label 3 avatars
      # @snapshot
      def avatar_3
        render(Primer::Beta::AvatarStack.new) do |component|
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
        end
      end

      # @label 4 avatars
      def avatar_4
        render(Primer::Beta::AvatarStack.new) do |component|
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
        end
      end

      # @label 5 avatars
      def avatar_5
        render(Primer::Beta::AvatarStack.new) do |component|
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
        end
      end
      #
      # @!endgroup

      # @!group More options
      #
      # @label Align right
      def align_right
        render(Primer::Beta::AvatarStack.new(align: :right)) do |component|
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
        end
      end

      # @label With tooltip
      def with_tooltip
        render(Primer::Beta::AvatarStack.new(tooltipped: true, body_arguments: { label: "This is a tooltip!" })) do |component|
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser", href: "primer.style")
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser", href: "primer.style")
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser", href: "primer.style")
        end
      end

      # @label With individual avatar tooltips
      def with_individual_tooltips
        render(Primer::Beta::AvatarStack.new) do |component|
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser", href: "https://github.com/user1", tooltip: "User 1")
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser", href: "https://github.com/user2", tooltip: "User 2")
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser", href: "https://github.com/user3", tooltip: "User 3")
        end
      end

      # @label With disabled expand
      def with_disabled_expand
        render(Primer::Beta::AvatarStack.new(disable_expand: true)) do |component|
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          component.with_avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
        end
      end
      #
      # @!endgroup
    end
  end
end
