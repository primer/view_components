# frozen_string_literal: true

module Primer
  module Alpha
    # A client-side mechanism to crop images.
    class ImageCrop < Primer::Component
      # A loading indicator that is shown while the image is loading.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :loading, lambda { |**system_arguments|
        deny_tag_argument(**system_arguments)
        system_arguments[:tag] = :div
        system_arguments[:"data-loading-slot"] = true

        Primer::BaseComponent.new(**system_arguments)
      }

      # @param src [String] The path of the image to crop.
      # @param rounded [Boolean] If the crop mask should be a circle. Defaults to true.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(src:, rounded: true, **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = "image-crop"
        @system_arguments[:src] = src
        @system_arguments[:rounded] = true if rounded
      end
    end
  end
end
