# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectPageHeaderDialogTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::PageHeader::Dialog.new(dialog_arguments: { id: "my_dialog", title: "A great dialog"},
                                                              button_arguments: { button_block: lambda { |b| "I AM A BUTTON" } }))

    assert_text("I AM A BUTTON")
  end
end
