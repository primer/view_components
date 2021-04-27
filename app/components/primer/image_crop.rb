# frozen_string_literal: true

module Primer
  # A client-side mechanism to crop images
  class ImageCrop < Primer::Component
    # A loading indicator that is shown while the image is loading.
    renders_one :loading, lambda { |**system_arguments|
      system_arguments[:tag] ||= :div
      system_arguments[:"data-loading-slot"] = true

      Primer::BaseComponent.new(**system_arguments)
    }

    # @example Simple cropper
    #   <%= render(Primer::ImageCrop.new(src: "https://github.com/koddsson.png")) %>
    #
    # @example Square cropper
    #   <%= render(Primer::ImageCrop.new(src: "https://github.com/koddsson.png", rounded: false)) %>
    #
    # @example Cropper with a custom loader
    #   <%= render(Primer::ImageCrop.new(src: "https://github.com/koddsson.png", rounded: false)) do |cropper| %>
    #     <% cropper.loading(style: "width: 120px") do %>
    #       <img src="spinner.gif />
    #     <% end %>
    #   <% end %>
    #
    # @param src [String] The path of the image to crop.
    # @param rounded [String] If the crop mask should be a circle. Defaults to true.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(src:, rounded: true, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = "image-crop"
      @system_arguments[:src] = src
      @system_arguments[:rounded] = rounded
    end
  end
end
