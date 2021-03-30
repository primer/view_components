# frozen_string_literal: true

require "test_helper"

class PrimerListComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_without_avatars
    render_inline(Primer::ListComponent.new)

    refute_component_rendered
  end

  def test_renders_list
    render_inline(Primer::ListComponent.new) do |c|
      c.item { "Item 1" }
      c.item { "Item 2" }
      c.item { "Item 3" }
    end

    assert_selector("ul") do
      assert_selector("li", text: "Item 1")
      assert_selector("li", text: "Item 2")
      assert_selector("li", text: "Item 3")
    end
  end

  def test_renders_unsyled_list
    render_inline(Primer::ListComponent.new(unstyled: true)) do |c|
      c.item { "Item 1" }
      c.item { "Item 2" }
      c.item { "Item 3" }
    end

    assert_selector("ul.list-style-none") do
      assert_selector("li", text: "Item 1")
      assert_selector("li", text: "Item 2")
      assert_selector("li", text: "Item 3")
    end
  end

  def test_renders_unsyled_items
    render_inline(Primer::ListComponent.new) do |c|
      c.item(unstyled: true) { "Item 1" }
      c.item { "Item 2" }
      c.item(unstyled: true) { "Item 3" }
    end

    assert_selector("ul") do
      assert_selector("li.list-style-none", text: "Item 1")
      assert_selector("li", text: "Item 2")
      assert_selector("li.list-style-none", text: "Item 3")
    end
  end
end
