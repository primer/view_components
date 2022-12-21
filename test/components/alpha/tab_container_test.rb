# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaTabContainerTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_without_content
    render_inline(Primer::Alpha::TabContainer.new)

    refute_selector("tab-container")
  end

  def test_renders_content
    render_inline(Primer::Alpha::TabContainer.new) { "content" }

    assert_selector("tab-container[data-view-component]", text: "content")
  end
end
