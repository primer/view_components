# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaDetailsTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_overlay_default_renders_details_overlay
    render_inline(Primer::Beta::Details.new(overlay: :default)) do |component|
      component.with_summary do
        "Summary"
      end
      component.with_body do
        "Body"
      end
    end

    assert_selector("details.details-overlay")
  end

  def test_overlay_dark_renders_details_overlay_dark
    render_inline(Primer::Beta::Details.new(overlay: :dark)) do |component|
      component.with_summary do
        "Summary"
      end
      component.with_body do
        "Body"
      end
    end

    assert_selector("details.details-overlay.details-overlay-dark")
  end

  def test_renders_details_reset_when_resetting_the_button_style
    render_inline(Primer::Beta::Details.new(reset: true)) do |component|
      component.with_summary do
        "Summary"
      end
      component.with_body do
        "Body"
      end
    end

    assert_selector("details.details-reset")
  end

  def test_default_component_renders_btn_summary
    render_inline(Primer::Beta::Details.new) do |component|
      component.with_summary do
        "Summary"
      end
      component.with_body do
        "Body"
      end
    end

    assert_selector("summary.btn")
  end

  def test_does_not_render_btn_if_button_false
    render_inline(Primer::Beta::Details.new) do |component|
      component.with_summary(button: false) do
        "Summary"
      end
      component.with_body do
        "Body"
      end
    end

    assert_selector("summary")
    refute_selector(".btn")
  end

  def test_falls_back_to_defaults_when_invalid_overlay_is_passed
    without_fetch_or_fallback_raises do
      render_inline(Primer::Beta::Details.new(overlay: :bar)) do |component|
        component.with_summary { "Summary" }
        component.with_body { "Body" }
      end
    end

    assert_selector("details")
    assert_selector(".btn")
  end

  def test_falls_back_to_default_body_tag_when_invalid_body_tag_is_passed
    without_fetch_or_fallback_raises do
      render_inline(Primer::Beta::Details.new) do |component|
        component.with_summary { "Summary" }
        component.with_body(tag: :img) { "Body" }
      end
    end

    assert_selector("div", text: "Body", visible: false)
    refute_selector("img", text: "Body", visible: false)
  end

  def test_passes_props_to_button
    render_inline(Primer::Beta::Details.new) do |component|
      component.with_summary(size: :small, scheme: :primary) do
        "Summary"
      end
      component.with_body do
        "Body"
      end
    end

    assert_selector("summary.btn.btn-sm.btn-primary")
  end

  def test_prevents_rendering_without_slots
    render_inline(Primer::Beta::Details.new)
    render_inline(Primer::Beta::Details.new) do |component|
      component.with_body { "Body" }
    end
    render_inline(Primer::Beta::Details.new) do |component|
      component.with_summary { "Summary" }
    end

    refute_selector("details")
    refute_selector("summary")
  end

  def test_status
    assert_component_state(Primer::Beta::Details, :beta)
  end
end
