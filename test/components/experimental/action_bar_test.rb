# frozen_string_literal: true

require "test_helper"

class PrimerExperimentalActionBarTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::Experimental::ActionBar.new) do |component|
      component.with_item_icon_button(icon: :heading, "aria-label": "Heading")
      component.with_item_divider
    end

    assert_selector("action-bar.ActionBar") do
      assert_selector("button[data-targets=\"action-bar.items\"]", count: 1) do
        assert_selector("tool-tip", text: "Heading", visible: :all)
      end
      assert_selector("hr.ActionBar-divider[data-targets=\"action-bar.items\"]", count: 1)
    end
  end
end
