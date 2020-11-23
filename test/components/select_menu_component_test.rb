# frozen_string_literal: true

require "test_helper"

class PrimerSelectMenuComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline Primer::SelectMenuComponent.new do |component|
      component.slot(:modal) do
        "hello world"
      end
    end

    assert_selector("div.SelectMenu div.SelectMenu-modal div.SelectMenu-list", text: /hello world/)
  end

  def test_prevents_rendering_without_slots
    render_inline(Primer::SelectMenuComponent.new)
    refute_selector("div")
  end
end
