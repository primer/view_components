# frozen_string_literal: true

require "test_helper"

class Primer::ViewHelperTest < Minitest::Test
  include Primer::ViewHelper
  include Primer::ComponentTestHelpers

  def test_renders_component_using_shorthand
    primer(:heading, tag: :h2) { "My Heading" }

    assert_selector("h2", text: "My Heading")
  end
end