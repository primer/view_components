# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectBorderBox::CollapsibleHeaderTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::BorderBox::CollapsibleHeader.new)

    assert_text("Add a test here")
  end
end
