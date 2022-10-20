# frozen_string_literal: true

module Primer
  # @label ImageCrop
  class ImageCropPreview < ViewComponent::Preview
    # @label Playground
    #
    # @param rounded [Boolean]
    def playground(rounded: false)
      render(Primer::ImageCrop.new(src: Primer::ExampleImage::BASE64_SRC, rounded: rounded))
    end

    # @label Default Options
    #
    # @param rounded [Boolean]
    def default(rounded: false)
      render(Primer::ImageCrop.new(src: Primer::ExampleImage::BASE64_SRC, rounded: rounded))
    end

    # @label Custom loading slot
    #
    # @param rounded [Boolean]
    def loading(rounded: false)
      render(Primer::ImageCrop.new(src: Primer::ExampleImage::BASE64_SRC, rounded: rounded)) do |c|
        c.with_loading { "Loading..." }
      end
    end
end
end
