# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectPageHeaderTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::PageHeader.new)

    assert_text("Add a test here")
  end
end
