# frozen_string_literal: true

require "test_helper"

class FlashComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::FlashComponent.new) { "foo" }

    assert_selector(".flash", text: "foo")
  end
end
