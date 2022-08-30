# frozen_string_literal: true

require "test_helper"

class PrimerBetaButtonTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::Beta::Button.new) { "Button" }

    assert_selector(".Button", text: "Button")
  end
end
