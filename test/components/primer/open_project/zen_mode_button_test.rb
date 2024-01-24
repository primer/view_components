# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectZenModeButtonTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::ZenModeButton.new)

    assert_selector(".zen-mode-button .octicon-screen-normal")
  end
end
