# frozen_string_literal: true

require "test_helper"

class PrimerTabContainerComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_without_content
    render_inline(Primer::TabContainerComponent.new)

    refute_selector("tab-container")
  end

  def test_renders_content
    render_inline(Primer::TabContainerComponent.new) { "content" }

    assert_selector("tab-container", text: "content")
  end
end
