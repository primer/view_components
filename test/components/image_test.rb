# frozen_string_literal: true

require "test_helper"

class PrimerImageTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_render_eager_loading_by_default
    render_inline(Primer::Image.new(src: "src", alt: "alt"))

    assert_selector("img[src='src'][alt='alt'][loading='eager']")
  end

  def test_lazy_loading
    render_inline(Primer::Image.new(src: "src", alt: "alt", loading: :lazy))

    assert_selector("img[src='src'][alt='alt'][loading='lazy']")
  end
end
