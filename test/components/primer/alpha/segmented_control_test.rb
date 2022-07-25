# frozen_string_literal: true

require "test_helper"

class PrimerAlphaSegmentedControlTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::SegmentedControl.new)

    assert_text("Add a test here")
  end
end
