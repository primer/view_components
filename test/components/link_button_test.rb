# frozen_string_literal: true

require "test_helper"

class PrimerLinkButtonTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::LinkButton.new) { "content" }

    assert_selector("button[type='button'].btn-link", text: "content")
  end
end
