# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectPageHeader::MenuTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::PageHeader::Menu.new(menu_arguments: {},
                                               button_arguments: { content_block: lambda { |b| "I AM A BUTTON" } }))

    assert_text("I AM A BUTTON")
  end
end
