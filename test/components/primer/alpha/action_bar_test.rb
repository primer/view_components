# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaActionBarTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::Alpha::ActionBar.new) do |component|
      component.with_item_icon_button(icon: :pencil, label: "Button 1")
      component.with_item_icon_button(icon: :pencil, label: "Button 2")
      component.with_item_icon_button(icon: :pencil, label: "Button 3")
      component.with_item_icon_button(icon: :pencil, label: "Button 4")
    end

    assert_selector("action-bar") do
      assert_selector("tool-tip", text: "Button 1")
      assert_selector("tool-tip", text: "Button 2")
      assert_selector("tool-tip", text: "Button 3")
      assert_selector("tool-tip", text: "Button 4")
      assert_selector("[data-target=\"action-bar.moreMenu\"]", visible: :hidden)
    end
  end

  def test_size_small
    render_inline(Primer::Alpha::ActionBar.new(size: :small)) do |component|
      component.with_item_icon_button(icon: :pencil, label: "Button 1")
      component.with_item_icon_button(icon: :pencil, label: "Button 2")
      component.with_item_icon_button(icon: :pencil, label: "Button 3")
      component.with_item_icon_button(icon: :pencil, label: "Button 4")
    end

    assert_selector("[data-targets=\"action-bar.items\"] .Button--small", count: 4)
  end
end
