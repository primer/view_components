# frozen_string_literal: true

require "test_helper"

class PrimerAlphaTooltipTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::Tooltip.new)

    assert_text("Add a test here")
  end
end
