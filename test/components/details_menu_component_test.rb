# frozen_string_literal: true

require "test_helper"

class PrimerDetailsMenuComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_details_menu_as_a_menu
    render_inline(Primer::DetailsMenuComponent.new)

    assert_selector("details-menu[role='menu']")
  end
end
