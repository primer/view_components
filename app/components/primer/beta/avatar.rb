# frozen_string_literal: true

module Primer
  module Beta
    # `Avatar` can be used to represent users and organizations on GitHub.
    #
    # - Use the default round avatar for users, and the `square` argument
    # for organizations or any other non-human avatars.
    # - By default, `Avatar` will render a static `<img>`. To have `Avatar` function as a link, set the `href` which will wrap the `<img>` in a `<a>`.
    # - Set `size` to update the height and width of the `Avatar` in pixels.
    # - To stack multiple avatars together, use <%= link_to_component(Primer::AvatarStackComponent) %>.
    #
    # @accessibility
    #   Images should have text alternatives that describe the information or function represented.
    #   If the avatar functions as a link, provide alt text that helps convey the function. For instance,
    #   if `Avatar` is a link to a user profile, the alt attribute should be `@kittenuser profile`
    #   rather than `@kittenuser`.
    #   [Learn more about best image practices (WAI Images)](https://www.w3.org/WAI/tutorials/images/)
    class Avatar < Primer::Component
      status :beta

      SMALL_THRESHOLD = 24

      # @example Default
      #   <%= render(Primer::Beta::Avatar.new(src: "http://placekitten.com/200/200", alt: "@kittenuser")) %>
      #
      # @example Square
      #   <%= render(Primer::Beta::Avatar.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", square: true)) %>
      #
      # @example Link
      #   <%= render(Primer::Beta::Avatar.new(href: "#", src: "http://placekitten.com/200/200", alt: "@kittenuser profile")) %>
      #
      # @example With size
      #   <%= render(Primer::Beta::Avatar.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", size: 16)) %>
      #   <%= render(Primer::Beta::Avatar.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", size: 20)) %>
      #   <%= render(Primer::Beta::Avatar.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", size: 24)) %>
      #   <%= render(Primer::Beta::Avatar.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", size: 28)) %>
      #   <%= render(Primer::Beta::Avatar.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", size: 32)) %>
      #   <%= render(Primer::Beta::Avatar.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", size: 36)) %>
      #
      # @param src [String] The source url of the avatar image.
      # @param alt [String] Passed through to alt on img tag.
      # @param size [Integer] Adds the avatar-small class if less than 24.
      # @param square [Boolean] Used to create a square avatar.
      # @param href [String] The URL to link to. If used, component will be wrapped by an `<a>` tag.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(src:, alt:, size: 20, square: false, href: nil, **system_arguments)
        @href = href
        @system_arguments = system_arguments
        @system_arguments[:tag] = :img
        @system_arguments[:src] = src
        @system_arguments[:alt] = alt
        @system_arguments[:size] = size
        @system_arguments[:height] = size
        @system_arguments[:width] = size

        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "avatar",
          "avatar-small" => size < SMALL_THRESHOLD,
          "circle" => !square,
          "lh-0" => href # Addresses an overflow issue with linked avatars
        )
      end

      def call
        if @href
          render(Primer::LinkComponent.new(href: @href, classes: @system_arguments[:classes])) do
            render(Primer::BaseComponent.new(**@system_arguments.except(:classes))) { content }
          end
        else
          render(Primer::BaseComponent.new(**@system_arguments)) { content }
        end
      end
    end
  end
end
