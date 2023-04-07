# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaActionBarTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::ActionBar.new)

    assert_text("Add a test here")
  end
end
