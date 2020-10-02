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

  def test_renders_details_reset_when_reseting_the_button_style
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

  def test_falls_back_to_defaults_when_invalid_button_and_overlay_are_passed
    without_fetch_or_fallback_raises do
      render_inline(Primer::DetailsComponent.new(button: :foo, overlay: :bar)) do |component|
        component.slot(:summary) { "Summary" }
        component.slot(:body) { "Body" }
      end
    end

    assert_selector("details")
    assert_selector(".btn")
  end

  def test_passes_props_to_button
    render_inline(Primer::DetailsComponent.new) do |component|
      component.slot(:summary, variant: :small, button_type: :primary) do
        "Summary"
      end
      component.slot(:body) do
        "Body"
      end
    end

    assert_selector("summary.btn.btn-sm.btn-primary")
  end

  def test_prevents_rendering_without_slots
    render_inline(Primer::DetailsComponent.new)
    render_inline(Primer::DetailsComponent.new) do |component|
      component.slot(:body) { "Body" }
    end
    render_inline(Primer::DetailsComponent.new) do |component|
      component.slot(:summary) { "Summary" }
    end

    refute_selector("details")
    refute_selector("summary")
  end

  def test_details_menu_is_direct_child
    menu = render_inline(Primer::DropdownMenuComponent.new(direction: :w)) { "Body" }
    render_inline(Primer::DetailsComponent.new) do |component|
      component.slot(:summary, variant: :small, button_type: :primary) do
        "Summary"
      end
      component.slot(:body) do
        menu.to_s.html_safe
      end
    end

    assert_selector("details > details-menu", visible: false)
  end
end
