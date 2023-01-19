# frozen_string_literal: true

require "components/test_helper"

class PrimerFlashTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::Beta::Flash.new) { "foo" }

    assert_selector(".flash", text: "foo")
    refute_selector(".flash-close")
    refute_selector(".flash-error")
    refute_selector(".flash-full")
    refute_selector(".octicon")
    refute_selector(".mb-4")
  end

  def test_renders_danger
    render_inline(Primer::Beta::Flash.new(scheme: :danger)) { "foo" }

    assert_selector(".flash.flash-error", text: "foo")
  end

  def test_uses_default_if_scheme_does_not_exist
    without_fetch_or_fallback_raises do
      render_inline(Primer::Beta::Flash.new(scheme: :zombieratsfromouterspace)) { "foo" }

      assert_selector(".flash", text: "foo")
    end
  end

  def test_renders_flash_full
    render_inline(Primer::Beta::Flash.new(full: true)) { "foo" }

    assert_selector(".flash.flash-full", text: "foo")
  end

  def test_renders_octicon_component
    render_inline(Primer::Beta::Flash.new(icon: :alert)) { "foo" }

    assert_selector(".flash .octicon.octicon-alert")
  end

  def test_renders_flash_close
    render_inline(Primer::Beta::Flash.new(dismissible: true)) { "foo" }

    assert_selector(".flash .flash-close")
  end

  def test_renders_flash_action_slot
    render_inline(Primer::Beta::Flash.new) do |component|
      component.with_action { "submit" }
    end

    assert_selector(".flash .flash-action", text: "submit")
  end

  def test_renders_spacious
    render_inline(Primer::Beta::Flash.new(spacious: true)) { "foo" }

    assert_selector(".flash.mb-4")
  end

  def test_bottom_margin_can_be_overridden
    render_inline(Primer::Beta::Flash.new(spacious: true, mb: 1)) { "foo" }

    assert_selector(".flash.mb-1")
  end

  def test_status
    assert_component_state(Primer::Beta::Flash, :beta)
  end
end
