# frozen_string_literal: true

module Primer
  # Use `Image` to render images.
  #
  # @accessibility
  #   Always provide a meaningful `alt`.
  class Image < Primer::Component
    # @example Default
    #
    #   <%= render(Primer::Image.new(src: "https://github.com/github.png", alt: "GitHub")) %>
    #
    # @example Helper
    #
    #   <%= primer_image(src: "https://github.com/github.png", alt: "GitHub") %>
    #
    # @example Lazy loading
    #
    #   <%= render(Primer::Image.new(src: "https://github.com/github.png", alt: "GitHub", lazy: true)) %>
    #
    # @example Custom size
    #
    #   <%= render(Primer::Image.new(src: "https://github.com/github.png", alt: "GitHub", height: 100, width: 100)) %>
    #
    # @param src [String] The source url of the image.
    # @param alt [String] Specifies an alternate text for the image.
    # @param lazy [Boolean] Whether or not to lazily load the image.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(src:, alt:, lazy: false, **system_arguments)
      @system_arguments = deny_tag_argument(**system_arguments)

      @src = src
      @system_arguments[:tag] = :img
      @system_arguments[:alt] = alt

      return unless lazy

      @system_arguments[:loading] = :lazy
      @system_arguments[:decoding] = :async
    end

    def call
      render(Primer::BaseComponent.new(src: image_path(@src), **@system_arguments))
    end
  end
end
