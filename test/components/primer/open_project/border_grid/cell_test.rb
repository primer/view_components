# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectBorderGridCellTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::BorderGrid::Cell.new)

    assert_selector(".BorderGrid-cell")
  end
end
