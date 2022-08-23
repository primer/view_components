# frozen_string_literal: true

require "test_helper"

class PrimerBetaButtonTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::Button.new)

    assert_text("Add a test here")
  end
end
