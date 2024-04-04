# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectPageHeaderMenuTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::PageHeader::Menu.new(menu_arguments: { anchor_align: :end },
                                                            button_arguments: { button_block: lambda { |b| "I AM A BUTTON" } })) do |menu|
      menu.with_item(label: "Subitem 1")
    end

    assert_text("I AM A BUTTON")
    assert_text("Subitem 1")
  end
end
