# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaUnorderedListTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::UnorderedList.new)

    assert_text("Add a test here")
  end
end
