# frozen_string_literal: true

require "test_helper"

class PrimerOcticonSymbolComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_one_octicon
    render_inline(Primer::OcticonSymbolComponent.new) do |c|
      c.icon(name: :alert)
    end

    assert_selector("svg defs symbol#octicon-alert-16 path")
  end

  def test_does_not_render_if_there_are_no_icons
    render_inline(Primer::OcticonSymbolComponent.new)

    refute_selector("svg")
  end

  def test_renders_octicon_with_alternate_sizes
    render_inline(Primer::OcticonSymbolComponent.new) do |c|
      c.icon(name: :alert)
      c.icon(name: :alert, size: :medium)
    end

    assert_selector("symbol#octicon-alert-16")
    assert_selector("symbol#octicon-alert-24")
  end

  def test_renders_one_octicon_when_only_one_size_exists
    render_inline(Primer::OcticonSymbolComponent.new) do |c|
      c.icon(name: :markdown)
      c.icon(name: :markdown, size: :medium)
    end

    assert_selector("symbol#octicon-markdown-16", count: 1)
  end
end
