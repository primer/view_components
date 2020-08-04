# frozen_string_literal: true

require "test_helper"

class PrimerLayoutComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::LayoutComponent.new) do |component|
      component.with(:sidebar) { "Sidebar" }
      component.with(:main) { "Main content" }
    end

    assert_text("Sidebar")
    assert_text("Main content")
  end

  def test_puts_sidebar_first_if_side_left
    render_inline(Primer::LayoutComponent.new(side: :left)) do |component|
      component.with(:sidebar) { "Sidebar" }
      component.with(:main) { "Main content" }
    end

    assert_selector(".d-flex > .col-3:first-child")
  end
end
