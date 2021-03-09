# frozen_string_literal: true

require "test_helper"

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
end
