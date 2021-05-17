# frozen_string_literal: true

require "test_helper"

class PrimerImageTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_render_without_loading_attribute_by_default
    render_inline(Primer::Image.new(src: "src", alt: "alt"))

    assert_selector("img[src='src'][alt='alt']")
    refute_selector("[loading]")
  end

  def test_lazy_loading
    render_inline(Primer::Image.new(src: "src", alt: "alt", lazy: true))

    assert_selector("img[src='src'][alt='alt'][loading='lazy'][decoding='async']")
  end
end
