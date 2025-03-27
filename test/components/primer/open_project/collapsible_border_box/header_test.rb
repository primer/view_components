# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectCollapsibleBorderBox::HeaderTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::CollapsibleBorderBox::Header.new)

    assert_text("Add a test here")
  end
end
