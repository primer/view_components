# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaTruncateTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_truncate_supports_block
    render_inline(Primer::Beta::Truncate.new) { "content" }

    assert_selector(".Truncate > .Truncate-text", text: "content")
  end

  def test_truncate_supports_block_with_arguments
    render_inline(Primer::Beta::Truncate.new(tag: :button, classes: "foo")) { "content" }

    assert_selector("button.Truncate.foo > span.Truncate-text", text: "content")
  end

  def test_truncate_wrapper_and_text_tag
    render_inline(Primer::Beta::Truncate.new(tag: :button)) do |component|
      component.with_item(tag: :strong) { "content" }
    end

    assert_selector("button.Truncate > strong.Truncate-text", text: "content")
  end

  def test_truncate_with_default_options
    render_inline(Primer::Beta::Truncate.new) do |component|
      component.with_item { "content" }
    end

    assert_selector(".Truncate > .Truncate-text", text: "content")
  end

  def test_truncate_with_custom_item_classes
    render_inline(Primer::Beta::Truncate.new) do |component|
      component.with_item(classes: "foo") { "content" }
    end

    assert_selector(".Truncate .Truncate-text.foo", text: "content")
  end

  def test_truncate_with_priority
    render_inline(Primer::Beta::Truncate.new) do |component|
      component.with_item { "content" }
      component.with_item(priority: true) { "priority content" }
    end

    assert_selector(".Truncate > .Truncate-text.Truncate-text--primary", text: "priority content")
  end

  def test_truncate_with_expandable
    render_inline(Primer::Beta::Truncate.new) do |component|
      component.with_item { "content" }
      component.with_item(tag: :button, expandable: true) { "expandable content" }
    end

    assert_selector(".Truncate > button.Truncate-text.Truncate-text--expandable", text: "expandable content")
  end

  def test_truncate_with_max_width
    render_inline(Primer::Beta::Truncate.new) do |component|
      component.with_item(max_width: 1337) { "content" }
    end

    assert_selector(".Truncate > .Truncate-text[style='max-width: 1337px;']", text: "content")
  end
end
