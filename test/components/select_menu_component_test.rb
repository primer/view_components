# frozen_string_literal: true

require "test_helper"

class PrimerSelectMenuComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_prevents_rendering_without_slots
    render_inline(Primer::SelectMenuComponent.new)
    refute_selector("div")
  end
end
