# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectDragHandleTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::DragHandle.new)

    assert_selector(".DragHandle .octicon")
  end

  def test_renders_larger_icon
    render_inline(Primer::OpenProject::DragHandle.new(size: :medium))

    assert_selector(".DragHandle .octicon[width='24']")
  end
end
