# frozen_string_literal: true

require "test_helper"

class PrimerDetailsComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_overlay_default_renders_details_overlay
    render_inline(Primer::DetailsComponent.new(overlay: :default)) do |component|
      component.slot(:summary) do
        "Summary"
      end
      component.slot(:body) do
        "Body"
      end
    end

    assert_selector("details.details-overlay")
  end

  def test_overlay_dark_renders_details_overlay_dark
    render_inline(Primer::DetailsComponent.new(overlay: :dark)) do |component|
      component.slot(:summary) do
        "Summary"
      end
      component.slot(:body) do
        "Body"
      end
    end

    assert_selector("details.details-overlay.details-overlay-dark")
  end

  def test_renders_details_reset_when_reset_true
    render_inline(Primer::DetailsComponent.new(reset: true)) do |component|
      component.slot(:summary) do
        "Summary"
      end
      component.slot(:body) do
        "Body"
      end
    end

    assert_selector("details.details-reset")
  end

  def test_default_component_renders_btn_summary
    render_inline(Primer::DetailsComponent.new) do |component|
      component.slot(:summary) do
        "Summary"
      end
      component.slot(:body) do
        "Body"
      end
    end

    assert_selector("summary.btn")
  end

  def test_allows_summary_customization
    render_inline(Primer::DetailsComponent.new) do |component|
      component.slot(:summary, classes: "btn-link", ml: 3) do
        "Summary"
      end
      component.slot(:body) do
        "Body"
      end
    end

    assert_selector("summary.btn-link.ml-3")
    refute_selector("summary.btn")
  end

  def test_allows_summary_without_classes
    render_inline(Primer::DetailsComponent.new) do |component|
      component.slot(:summary, classes: "") do
        "Summary"
      end
      component.slot(:body) do
        "Body"
      end
    end

    assert_selector("summary")
    refute_selector("summary.btn")
  end

  def test_falls_back_to_defaults_when_invalid_overlay_is_passed
    without_fetch_or_fallback_raises do
      render_inline(Primer::DetailsComponent.new(overlay: :bar)) do |component|
        component.slot(:summary) { "Summary" }
        component.slot(:body) { "Body" }
      end
    end

    assert_selector("details")
    assert_selector(".btn")
  end
end
