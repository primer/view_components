# frozen_string_literal: true

require "system/test_case"

class IntegrationBetaRelativeTimeTest < System::TestCase
  TODAY = "2026-11-03T15:04:00Z"

  def test_renders_component
    visit_preview(:default)

    assert_selector("relative-time")
  end

  def test_renders_compact_absolute_time
    assert_preview_text("today at 3:04 PM", datetime: TODAY)
    assert_selector("relative-time[title='Nov 3, 2026, 15:04 UTC']")
    assert_preview_text("Nov 2, 2026", datetime: "2026-11-02T15:04:00Z")
  end

  def test_compact_preset_does_not_force_absolute_output
    assert_preview_text("1 hour ago", datetime: TODAY, threshold: "P30D")
  end

  def test_compact_preset_preserves_elapsed_output
    assert_preview_text("1h", datetime: TODAY, format: :elapsed)
  end

  private

  def assert_preview_text(expected, **params)
    visit_preview(:compact_absolute, params)
    element = find("relative-time[absolute-format='compact']")

    # Freeze the browser clock only while the real element recalculates its display.
    text = element.evaluate_script(<<~JS)
      (() => {
        const now = Date.now;
        Date.now = () => Date.parse("2026-11-03T16:04:00Z");
        try {
          this.update();
          return this.shadowRoot.textContent;
        } finally {
          Date.now = now;
        }
      })()
    JS
    assert_equal expected, text
  end
end
