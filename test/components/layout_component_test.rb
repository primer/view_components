# frozen_string_literal: true

require "components/test_helper"

class PrimerLayoutComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::LayoutComponent.new) do |component|
      component.with_sidebar { "Sidebar" }
      component.with_main { "Main content" }
    end

    assert_text("Sidebar")
    assert_text("Main content")
  end

  def test_puts_sidebar_first_if_side_left
    render_inline(Primer::LayoutComponent.new(side: :left)) do |component|
      component.with_sidebar { "Sidebar" }
      component.with_main { "Main content" }
    end

    assert_selector(".d-flex > .col-3:first-child")
  end

  def test_defaults_to_col_3_on_sidebar
    render_inline(Primer::LayoutComponent.new) do |component|
      component.with_sidebar { "Sidebar" }
      component.with_main { "Main content" }
    end

    assert_selector(".d-flex > .col-9:first-child") # main
    assert_selector(".d-flex > .col-3:last-child") # sidebar
  end

  def test_defaults_to_col_3_on_sidebar_if_value_is_invalid
    without_fetch_or_fallback_raises do
      render_inline(Primer::LayoutComponent.new(sidebar_col: Primer::LayoutComponent::MAX_COL)) do |component|
        component.with_sidebar { "Sidebar" }
        component.with_main { "Main content" }
      end
    end

    assert_selector(".d-flex > .col-9:first-child") # main
    assert_selector(".d-flex > .col-3:last-child") # sidebar
  end

  def test_changes_sidebar_col_and_main_col_accordingly
    render_inline(Primer::LayoutComponent.new(sidebar_col: 5)) do |component|
      component.with_sidebar { "Sidebar" }
      component.with_main { "Main content" }
    end

    assert_selector(".d-flex > .col-7:first-child") # main
    assert_selector(".d-flex > .col-5:last-child") # sidebar
  end
end
