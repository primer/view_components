# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectFlexLayoutTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::FlexLayout.new) do |flex|
      flex.with_box { "Block 1" }
      flex.with_box { "Block 2" }
    end

    assert_selector(".d-flex")
  end

  def test_renders_rows
    render_inline(Primer::OpenProject::FlexLayout.new) do |grid|
      grid.with_row { "Block 1" }
      grid.with_row { "Block 2" }
    end

    assert_selector(".d-flex.flex-column")
  end

  def test_renders_columns
    render_inline(Primer::OpenProject::FlexLayout.new) do |grid|
      grid.with_column { "Block 1" }
      grid.with_column { "Block 2" }
    end

    assert_selector(".d-flex.flex-row")
  end

  def test_does_not_render_if_no_items_provided
    error = assert_raises(ArgumentError) do
      render_inline(Primer::OpenProject::FlexLayout.new)
    end

    assert_equal(error.message, "You have to provide either rows, columns or boxes as a slot")
  end

  def test_does_not_render_if_rows_and_columns_are_mixed
    error = assert_raises(ArgumentError) do
      render_inline(Primer::OpenProject::FlexLayout.new) do |flex|
        flex.with_column { "Block 1" }
        flex.with_row { "Block 2" }
      end
    end

    assert_equal(error.message, "You can't mix row, column and box slots")
  end

  def test_renders_another_flex_layout_as_child
    render_inline(Primer::OpenProject::FlexLayout.new) do |flex|
      flex.with_row(flex_layout: true) do |flex_child|
        flex_child.with_column { "Block 1" }
        flex_child.with_column { "Block 2" }
      end

      flex.with_row { "Block 3" }
    end

    assert_selector(".d-flex.flex-column")
    assert_selector(".d-flex.flex-column .d-flex.flex-row")
  end
end
