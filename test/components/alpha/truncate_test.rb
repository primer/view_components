# frozen_string_literal: true

require "test_helper"

class PrimerAlphaTruncateTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_truncate_with_default_options
    render_inline(Primer::Alpha::Truncate.new) do |component|
      component.text { "content" }
    end

    assert_selector(".Truncate > .Truncate-text", text: "content")
  end

  def test_truncate_with_primary
    render_inline(Primer::Alpha::Truncate.new) do |component|
      component.text { "content" }
      component.text(primary: true) { "primary content" }
    end

    assert_selector(".Truncate > .Truncate-text.Truncate-text--primary", text: "primary content")
  end

  def test_truncate_with_expandable
    render_inline(Primer::Alpha::Truncate.new) do |component|
      component.text { "content" }
      component.text(tag: :button, expandable: true) { "expandable content" }
    end

    assert_selector(".Truncate > button.Truncate-text.Truncate-text--expandable", text: "expandable content")
  end

  def test_truncate_with_max_width
    render_inline(Primer::Alpha::Truncate.new) do |component|
      component.text(max_width: 1337) { "content" }
    end

    assert_selector(".Truncate > .Truncate-text[style='max-width: 1337px;']", text: "content")
  end
end
