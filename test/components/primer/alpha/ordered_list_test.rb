# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaOrderedListTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::Alpha::OrderedList.new) do |c|
      c.with_item { "Item 1" }
    end
    assert_selector(".OrderedList")
  end

  def test_does_not_render_if_no_items
    render_inline(Primer::Alpha::OrderedList.new)
    refute_selector(".OrderedList")
  end

  def test_renders_multiple_items
    render_inline(Primer::Alpha::OrderedList.new) do |c|
      c.with_item { "Item 1" }
      c.with_item { "Item 2" }
    end
    assert_text("Item 1")
    assert_text("Item 2")
  end
end
