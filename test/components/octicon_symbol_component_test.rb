# frozen_string_literal: true

require "test_helper"

class PrimerOcticonSymbolComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_one_octicon
    render_inline(Primer::OcticonSymbolComponent.new) do |c|
      c.icon(symbol: :alert)
    end

    assert_selector("svg defs symbol#octicon-alert-16 path", visible: false)
  end

  def test_does_not_render_if_there_are_no_icons
    render_inline(Primer::OcticonSymbolComponent.new)

    refute_selector("svg", visible: false)
  end

  def test_renders_octicon_with_alternate_sizes
    render_inline(Primer::OcticonSymbolComponent.new) do |c|
      c.icon(symbol: :alert)
      c.icon(symbol: :alert, size: :medium)
    end

    assert_selector("symbol#octicon-alert-16", visible: false)
    assert_selector("symbol#octicon-alert-24", visible: false)
  end

  def test_renders_one_octicon_when_only_one_size_exists
    render_inline(Primer::OcticonSymbolComponent.new) do |c|
      c.icon(symbol: :markdown)
      c.icon(symbol: :markdown, size: :medium)
    end

    assert_selector("symbol#octicon-markdown-16", count: 1, visible: false)
  end
end
