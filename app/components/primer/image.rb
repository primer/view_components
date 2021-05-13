# frozen_string_literal: true

module Primer
  # Use `Image` to render images. It can be rendered using the `primer_image` helper.
  #
  # @accessibility
  #   Always provide a meaningful `alt` for your images.
  class Image < Primer::Component
    DEFAULT_LOADING = :eager
    LOADING_OPTIONS = [DEFAULT_LOADING, :lazy].freeze

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
    #   <%= render(Primer::Image.new(src: "https://github.com/github.png", alt: "GitHub", loading: :lazy)) %>
    #
    # @example Custom size
    #
    #   <%= render(Primer::Image.new(src: "https://github.com/github.png", alt: "GitHub", height: 100, width: 100)) %>
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(src:, alt:, loading: DEFAULT_LOADING, **system_arguments)
      @system_arguments = system_arguments

      @system_arguments[:tag] = :img
      @system_arguments[:src] = src
      @system_arguments[:alt] = alt
      @system_arguments[:loading] = fetch_or_fallback(LOADING_OPTIONS, loading, DEFAULT_LOADING)
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments))
    end
  end
end
