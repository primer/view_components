# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectGridLayoutAreaTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::GridLayout::Area.new("grid-layout", "area"))

    assert_selector(".grid-layout--area[style='grid-area: area']")
  end
end
