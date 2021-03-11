# frozen_string_literal: true

module Primer
  # Avatars are images used to represent users and organizations on GitHub.
  # Use the default round avatar for users, and the `square` argument
  # for organizations or any other non-human avatars.
  class AvatarComponent < Primer::Component
    status :beta

    SMALL_THRESHOLD = 24

    # @example Default
    #   <%= render(Primer::AvatarComponent.new(src: "http://placekitten.com/200/200", alt: "@kittenuser")) %>
    #
    # @example Square
    #   <%= render(Primer::AvatarComponent.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", square: true)) %>
    #
    # @example Link
    #   <%= render(Primer::AvatarComponent.new(href: "#", src: "http://placekitten.com/200/200", alt: "@kittenuser")) %>
    #
    # @param src [String] The source url of the avatar image.
    # @param alt [String] Passed through to alt on img tag.
    # @param size [Integer] Adds the avatar-small class if less than 24.
    # @param square [Boolean] Used to create a square avatar.
    # @param href [String] The URL to link to. If used, component will be wrapped by an `<a>` tag.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(src:, alt:, size: 20, square: false, href: nil, classes: nil, **image_arguments)
      @href = href

      @image_arguments = image_arguments
      @image_arguments[:tag] = :img
      @image_arguments[:src] = src
      @image_arguments[:alt] = alt
      @image_arguments[:size] = size
      @image_arguments[:height] = size
      @image_arguments[:width] = size

      @avatar_classes = class_names(
        "avatar",
        "avatar-small" => size < SMALL_THRESHOLD,
        "circle" => !square
      )

      @all_classes = class_names(classes, @avatar_classes)
    end

    def call
      if @href
        render(Primer::LinkComponent.new(href: @href, classes: @all_classes)) do
          render(Primer::BaseComponent.new(classes: @avatar_classes, **@image_arguments)) { content }
        end
      else
        render(Primer::BaseComponent.new(classes: @all_classes, **@image_arguments)) { content }
      end
    end
  end
end
