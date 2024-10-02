# frozen_string_literal: true

require "components/test_helper"

class PrimerStackItemTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::Alpha::StackItem.new) do
      "content"
    end

    assert_text("content")
  end

  def test_attaches_stack_item_class
    render_inline(Primer::Alpha::StackItem.new) do
      "content"
    end

    assert_selector(".StackItem")
  end

  def test_uses_div_as_default_tag
    render_inline(Primer::Alpha::StackItem.new) do
      "content"
    end

    assert_selector("div.StackItem")
  end

  def test_allows_customizing_tag
    render_inline(Primer::Alpha::StackItem.new(tag: :a)) do
      "content"
    end

    assert_selector("a.StackItem")
  end

  def test_renders_static_prop_grow_with_true_option
    render_inline(Primer::Alpha::StackItem.new(grow: true)) do
      "content"
    end

    assert_selector("div[data-grow=\"true\"]")
  end

  def test_ignores_static_prop_grow_with_false_option
    render_inline(Primer::Alpha::StackItem.new(grow: false)) do
      "content"
    end

    refute_selector("div[data-grow]")
  end

  def test_ignores_static_prop_grow_by_default
    render_inline(Primer::Alpha::StackItem.new) do
      "content"
    end

    refute_selector("div[data-grow]")
  end

  def test_ignores_responsive_prop_grow_with_false_option
    render_inline(Primer::Alpha::StackItem.new(grow: [false]*5)) do
      "content"
    end

    refute_selector("div[data-grow]")
    refute_selector("div[data-grow-regular]")
    refute_selector("div[data-grow-narrow]")
    refute_selector("div[data-grow-wide]")
  end

  def test_renders_responsive_prop_grow_with_true_option
    render_inline(Primer::Alpha::StackItem.new(grow: [true] * 5)) do
      "content"
    end

    assert_selector("div[data-grow=\"true\"]")
    assert_selector("div[data-grow-regular=\"true\"]")
    assert_selector("div[data-grow-narrow=\"true\"]")
    assert_selector("div[data-grow-wide=\"true\"]")
  end

  def test_renders_responsive_prop_grow_with_responsive_options
    render_inline(Primer::Alpha::StackItem.new(grow: [true, false, false, true, false])) do
      "content"
    end

    assert_selector("div[data-grow=\"true\"]")
    refute_selector("div[data-grow-regular]")
    refute_selector("div[data-grow-narrow]")
    assert_selector("div[data-grow-wide=\"true\"]")
  end

  def test_renders_wide_when_xl_option_provided
    render_inline(Primer::Alpha::StackItem.new(grow: [false, false, false, false, true])) do
      "content"
    end

    refute_selector("div[data-grow]")
    refute_selector("div[data-grow-regular]")
    refute_selector("div[data-grow-narrow]")
    assert_selector("div[data-grow-wide=\"true\"]")
  end

  def test_status
    assert_component_state(Primer::Alpha::StackItem, :alpha)
  end
end
