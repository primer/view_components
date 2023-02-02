# frozen_string_literal: true

require "lib/test_helper"
require_relative "../../../app/lib/primer/view_helper"

class Primer::ViewHelperTest < Minitest::Test
  include Primer::ViewHelper
  include Primer::ComponentTestHelpers

  # The helper calls #render, but it is not available in tests
  alias render render_inline

  def test_renders_heading_using_shorthand
    primer_heading(tag: :h2) { "My Heading" }

    assert_selector("h2", text: "My Heading")
  end

  def test_renders_octicon_using_shorthand
    primer_octicon icon: :star

    assert_selector(".octicon.octicon-star")
  end

  def test_renders_octicon_using_positional_argument
    primer_octicon :star

    assert_selector(".octicon.octicon-star")
  end

  def test_renders_image_helper
    primer_image(src: "https://github.com/github.png", alt: "alt")

    assert_selector("img[src='https://github.com/github.png'][alt='alt']")
  end
end
