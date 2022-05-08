# frozen_string_literal: true

require "test_helper"

class PrimerAlphaFormControlTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::FormControl.new)

    assert_text("Add a test here")
  end
end
