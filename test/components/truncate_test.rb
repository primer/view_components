# frozen_string_literal: true

require "components/test_helper"

class PrimerTruncateTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_truncated_content
    render_inline(Primer::Truncate.new) { "content" }

    assert_selector(".css-truncate.css-truncate-overflow", text: "content")
  end

  def test_renders_truncated_tag_options
    Primer::Truncate::TAG_OPTIONS.each do |tag|
      render_inline(Primer::Truncate.new(tag: tag)) { "content" }

      assert_selector("#{tag}.css-truncate.css-truncate-overflow", text: "content")
    end
  end

  def test_falls_back_when_tag_isnt_valid
    without_fetch_or_fallback_raises do
      render_inline(Primer::Truncate.new(tag: :ul)) { "content" }

      assert_selector("div.css-truncate")
    end
  end

  def test_renders_truncated_inline
    render_inline(Primer::Truncate.new(inline: true)) { "content" }

    assert_selector(".css-truncate.css-truncate-target", text: "content")
  end

  def test_renders_truncated_inline_expandable
    render_inline(Primer::Truncate.new(inline: true, expandable: true)) { "content" }

    assert_selector(".css-truncate.css-truncate-target.expandable", text: "content")
  end

  def test_does_not_render_expandable_when_not_inline
    render_inline(Primer::Truncate.new(expandable: true)) { "content" }

    assert_selector(".css-truncate", text: "content")
    refute_selector(".expandable")
  end

  def test_renders_custom_max_width
    render_inline(Primer::Truncate.new(max_width: 100)) { "content" }

    assert_selector(".css-truncate", text: "content", style: "max-width: 100px;")
  end
end
