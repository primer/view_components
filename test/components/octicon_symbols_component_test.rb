# frozen_string_literal: true

require "components/test_helper"

class PrimerOcticonSymbolsComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_one_octicon
    icons = [
      {
        symbol: :alert
      }
    ]

    render_inline(Primer::OcticonSymbolsComponent.new(icons: icons))

    assert_selector("svg symbol#octicon_alert_16 path", visible: false)
  end

  def test_does_not_render_if_there_are_no_icons
    render_inline(Primer::OcticonSymbolsComponent.new)

    refute_selector("svg", visible: false)
  end

  def test_renders_octicon_with_alternate_sizes
    icons = [
      {
        symbol: :alert
      },
      {
        symbol: :alert,
        size: Primer::Beta::Octicon::SIZE_MEDIUM
      }
    ]

    render_inline(Primer::OcticonSymbolsComponent.new(icons: icons))

    assert_selector("symbol#octicon_alert_16", visible: false)
    assert_selector("symbol#octicon_alert_24", visible: false)
  end

  def test_renders_one_octicon_when_only_one_size_exists
    icons = [
      {
        symbol: :markdown
      },
      {
        symbol: :markdown,
        size: Primer::Beta::Octicon::SIZE_MEDIUM
      }
    ]

    render_inline(Primer::OcticonSymbolsComponent.new(icons: icons))

    assert_selector("symbol#octicon_markdown_16", count: 1, visible: false)
  end
end
