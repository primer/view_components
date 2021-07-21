# frozen_string_literal: true

require "test_helper"

class PrimerAlphaTruncateTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_truncate_supports_block
    render_inline(Primer::Alpha::Truncate.new) { "content" }

    assert_selector(".Truncate > .Truncate-text", text: "content")
  end

  def test_truncate_supports_block_with_arguments
    render_inline(Primer::Alpha::Truncate.new(tag: :button, primary: true, expandable: true, max_width: 1337)) { "content" }

    assert_selector(".Truncate > button.Truncate-text.Truncate-text--primary.Truncate-text--expandable[style='max-width: 1337px;']", text: "content")
  end

  def test_truncate_wrapper_and_text_tag
    render_inline(Primer::Alpha::Truncate.new(tag: :button)) do |component|
      component.item(tag: :strong) { "content" }
    end

    assert_selector("button.Truncate > strong.Truncate-text", text: "content")
  end

  def test_truncate_with_default_options
    render_inline(Primer::Alpha::Truncate.new) do |component|
      component.item { "content" }
    end

    binding.irb

    assert_selector(".Truncate > .Truncate-text", text: "content")
  end

  def test_truncate_with_primary
    render_inline(Primer::Alpha::Truncate.new) do |component|
      component.item { "content" }
      component.item(primary: true) { "primary content" }
    end

    assert_selector(".Truncate > .Truncate-text.Truncate-text--primary", text: "primary content")
  end

  def test_truncate_with_expandable
    render_inline(Primer::Alpha::Truncate.new) do |component|
      component.item { "content" }
      component.item(tag: :button, expandable: true) { "expandable content" }
    end

    assert_selector(".Truncate > button.Truncate-text.Truncate-text--expandable", text: "expandable content")
  end

  def test_truncate_with_max_width
    render_inline(Primer::Alpha::Truncate.new) do |component|
      component.item(max_width: 1337) { "content" }
    end

    assert_selector(".Truncate > .Truncate-text[style='max-width: 1337px;']", text: "content")
  end
end
