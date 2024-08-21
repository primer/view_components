# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectConfirmationMessageTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::ConfirmationMessage.new)

    assert_text("Add a test here")
  end
end
