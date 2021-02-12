# frozen_string_literal: true

module Primer
  # Avatars are images used to represent users and organizations on GitHub.
  # Use the default round avatar for users, and the `square` argument
  # for organizations or any other non-human avatars.
  class AvatarComponent < Primer::Component
    SMALL_THRESHOLD = 24

    # @example auto|Default
    #   <%= render(Primer::AvatarComponent.new(src: "http://placekitten.com/200/200", alt: "@kittenuser")) %>
    #
    # @example auto|Link
    #   <%= render(Primer::AvatarComponent.new(link: true, href: "#", src: "http://placekitten.com/200/200", alt: "@kittenuser")) %>
    #
    # @param link [Boolean] Whether the avatar should be wrapped in a link.
    # @param src [String] The source url of the avatar image
    # @param alt [String] Passed through to alt on img tag
    # @param size [Integer] Adds the avatar-small class if less than 24
    # @param square [Boolean] Used to create a square avatar.
    # @param href [String] The URL to link to. Required when link = true.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(link: false, src:, alt:, size: 20, square: false, **system_arguments)
      @link = link
      @system_arguments = system_arguments
      @system_arguments[:tag] = :img
      @system_arguments[:src] = src
      @system_arguments[:alt] = alt
      @system_arguments[:size] = size
      @system_arguments[:height] = size
      @system_arguments[:width] = size

      @system_arguments[:classes] = class_names(
        system_arguments[:classes],
        "avatar" => !link,
        "avatar--small" => size < SMALL_THRESHOLD,
        "CircleBadge" => !square
      )
    end

    def call
      if @link
        render(Primer::LinkComponent.new(href: @system_arguments[:href], classes: "avatar")) do
          render(Primer::BaseComponent.new(**@system_arguments.except(:href))) { content }
        end
      else
        render(Primer::BaseComponent.new(**@system_arguments)) { content }
      end
    end
  end
end
