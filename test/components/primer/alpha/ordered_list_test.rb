# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaOrderedListTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OrderedList.new)

    assert_text("Add a test here")
  end
end
