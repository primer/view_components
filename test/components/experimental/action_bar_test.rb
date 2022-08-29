# frozen_string_literal: true

require "test_helper"

class PrimerExperimentalActionBarTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::Experimental::ActionBar.new) do |component|
      component.with_item_icon_button(icon: :heading, "aria-label": "Heading")
    end

    assert_selector("action-bar.ActionBar") do
      assert_selector(".ActionBar-item[data-targets=\"action-bar.items\"]") do
        assert_selector("tool-tip", text: "Heading", visible: :all)
      end
    end
  end
end
