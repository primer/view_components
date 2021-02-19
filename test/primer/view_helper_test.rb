# frozen_string_literal: true

require "test_helper"

class Primer::ViewHelperTest < Minitest::Test
  include Primer::ViewHelper
  include Primer::ComponentTestHelpers

  # The helper calls #render, but it is not available in tests
  alias render render_inline

  def test_renders_component_using_shorthand
    primer(:heading, tag: :h2) { "My Heading" }

    assert_selector("h2", text: "My Heading")
  end

  def test_raises_if_component_is_not_registered
    assert_raises Primer::ViewHelper::ViewHelperNotFound do
      primer(:not_registered)
    end
  end
end
