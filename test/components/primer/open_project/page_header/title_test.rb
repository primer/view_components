# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectPageHeaderTitleTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::PageHeader::Title.new) { "Hello" }

    assert_text("Hello")
  end
end
