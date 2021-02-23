# frozen_string_literal: true

require "test_helper"

class PrimerTabNavContainerComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_without_nav
    render_inline(Primer::TabNavContainerComponent.new)

    refute_selector("tab-container")
  end

  def test_renders_tabbed_content
    render_inline(Primer::TabNavContainerComponent.new) do |c|
      c.nav do |nav|
        nav.tab(title: "Tab 1", selected: true) { "Content 1" }
        nav.tab(title: "Tab 2") { "Content 2" }
      end
    end

    assert_selector("tab-container") do
      assert_selector(".tabnav") do
        assert_selector("nav.tabnav-tabs[role='tablist']") do
          assert_selector("button.tabnav-tab[type='button'][aria-selected='true'][role='tab']", text: "Tab 1")
          assert_selector("button.tabnav-tab[type='button'][role='tab']", text: "Tab 2")
        end
      end
      assert_selector("div[role='tabpanel']", text: "Content 1")
      assert_selector("div[role='tabpanel']", text: "Content 2", visible: false)
    end
  end
end
