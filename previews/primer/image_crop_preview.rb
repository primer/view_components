# frozen_string_literal: true

module Primer
  # @label ImageCrop
  class ImageCropPreview < ViewComponent::Preview
    # @label Default Options
    #
    # @param rounded [Boolean]
    def default(rounded: false)
      render(Primer::ImageCrop.new(src: "https://github.com/octocat.png", rounded: rounded))
    end

    # @label Custom loading slot
    #
    # @param rounded [Boolean]
    def loading(rounded: false)
      render(Primer::ImageCrop.new(src: "https://github.com/octocat.png", rounded: rounded)) do |c|
        c.with_loading { "Loading..." }
      end
    end
end
end
