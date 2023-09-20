# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectBorderGridTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::BorderGrid.new) do |grid|
      grid.with_row { "Block 1" }
      grid.with_row { "Block 2" }
      grid.with_row { "Block 3" }
    end

    assert_selector(".BorderGrid")
    assert_selector(".BorderGrid-row", count: 3)
    assert_selector(".BorderGrid-row .BorderGrid-cell", text: "Block 1")
  end

  def test_renders_spacious
    render_inline(Primer::OpenProject::BorderGrid.new(spacious: true)) do |grid|
      grid.with_row { "Block 1" }
      grid.with_row { "Block 2" }
      grid.with_row { "Block 3" }
    end

    assert_selector(".BorderGrid.BorderGrid--spacious")
  end
end
