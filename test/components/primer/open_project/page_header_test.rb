# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectPageHeaderTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::PageHeader.new) { |header| header.with_title { 'Hello' } }

    assert_text("Hello")
  end
end
