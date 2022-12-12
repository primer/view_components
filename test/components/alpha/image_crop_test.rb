# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaImageCropTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_simple
    render_inline(Primer::Alpha::ImageCrop.new(src: "image.png"))

    assert_selector("image-crop[data-view-component][src=\"image.png\"][rounded]") do
      assert_selector("svg.flex-1.anim-rotate")
    end
  end

  def test_square_cropper
    render_inline Primer::Alpha::ImageCrop.new(src: "image.png", rounded: false)

    assert_selector("image-crop[data-view-component][src=\"image.png\"]")
  end

  def test_custom_loading_element
    render_inline Primer::Alpha::ImageCrop.new(src: "image.png") do |crop|
      crop.with_loading do
        "Loading.."
      end
    end

    assert_selector("image-crop[data-view-component][src=\"image.png\"][rounded]") do
      assert_selector("div[data-loading-slot]") do
        assert_text("Loading..")
      end
    end
  end
end
