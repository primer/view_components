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
      def playground(number_of_avatars: 1, tag: :div, align: :left, tooltipped: false, tooltip_label: "This is a tooltip!")
        render(Primer::Beta::AvatarStack.new(tag: tag, align: align, tooltipped: tooltipped, body_arguments: { label: tooltip_label })) do |c|
          Array.new(number_of_avatars || 1) do
            c.avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          end
        end
      end

      # @label Default options
      #
      # @param number_of_avatars [Integer] number
      # @param tag select [["div", div], ["span", span]]
      # @param align select [["Left", left], ["Right", right]]
      # @param tooltipped toggle
      # @param tooltip_label text
      def default(number_of_avatars: 1, tag: :div, align: :left, tooltipped: false, tooltip_label: "This is a tooltip!")
        render(Primer::Beta::AvatarStack.new(tag: tag, align: align, tooltipped: tooltipped, body_arguments: { label: tooltip_label })) do |c|
          Array.new(number_of_avatars || 1) do
            c.avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          end
        end
      end

      # @!group More Examples

      # @label Align right
      def align_right
        render(Primer::Beta::AvatarStack.new(align: :right)) do |c|
          c.avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          c.avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          c.avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
        end
      end

      # @label With tooltip
      def with_tooltip
        render(Primer::Beta::AvatarStack.new(tooltipped: true, body_arguments: { label: "This is a tooltip!" })) do |c|
          c.avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          c.avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
          c.avatar(src: Primer::ExampleImage::BASE64_SRC, alt: "@kittenuser")
        end
      end
      # @!endgroup
    end
  end
end
