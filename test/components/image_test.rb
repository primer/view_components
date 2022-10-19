# frozen_string_literal: true

require "components/test_helper"

class PrimerImageTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_render_without_loading_attribute_by_default
    render_inline(Primer::Image.new(src: "https://github.com/github.png", alt: "alt"))

    assert_selector("img[src='https://github.com/github.png'][alt='alt']")
    refute_selector("[loading]")
  end

  def test_lazy_loading
    render_inline(Primer::Image.new(src: "https://github.com/github.png", alt: "alt", lazy: true))

    assert_selector("img[src='https://github.com/github.png'][alt='alt'][loading='lazy'][decoding='async']")
  end

  def test_restricts_allowed_system_arguments
    with_raise_on_invalid_options(true) do
      error = assert_raises(ArgumentError) do
        render_inline(Primer::Image.new(src: "https://github.com/github.png", alt: "alt", tag: :div))
      end

      assert_includes(error.message, "This component has a fixed tag.")
    end
  end

  def test_strips_denied_system_arguments
    with_raise_on_invalid_options(false) do
      render_inline(Primer::Image.new(src: "https://github.com/github.png", alt: "alt", tag: :div))
    end

    refute_selector("div")
  end
end
