# frozen_string_literal: true

require "test_helper"

class PrimerFlashTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::Beta::Flash.new) { "foo" }

    assert_selector(".Banner")
    assert_selector(".Banner-message", text: "foo")
    refute_selector(".Banner-close")
    refute_selector(".Banner--error")
    refute_selector(".Banner--warning")
    refute_selector(".Banner--success")
    refute_selector(".Banner--full")
    refute_selector(".Banner--fullWhenNarrow")
    refute_selector(".octicon")
  end

  def test_renders_danger
    render_inline(Primer::Beta::Flash.new(scheme: :danger)) { "foo" }

    assert_selector(".Banner.Banner--error", text: "foo")
  end

  def test_uses_default_if_scheme_does_not_exist
    without_fetch_or_fallback_raises do
      render_inline(Primer::Beta::Flash.new(scheme: :zombieratsfromouterspace)) { "foo" }

      assert_selector(".Banner", text: "foo")
      refute_selector(".Banner--error")
      refute_selector(".Banner--warning")
      refute_selector(".Banner--success")
    end
  end

  def test_renders_flash_full
    render_inline(Primer::Beta::Flash.new(full: true)) { "foo" }

    assert_selector(".Banner.Banner--full", text: "foo")
  end

  def test_renders_octicon_component
    render_inline(Primer::Beta::Flash.new(icon: :alert)) { "foo" }

    assert_selector(".Banner .octicon.octicon-alert")
  end

  def test_renders_flash_close
    render_inline(Primer::Beta::Flash.new(dismissible: true)) { "foo" }

    assert_selector(".Banner .Banner-close")
  end

  def test_renders_flash_action_slot
    render_inline(Primer::Beta::Flash.new) do |component|
      component.action { "submit" }
    end

    assert_selector(".Banner .Banner-actions", text: "submit")
  end

  def test_status
    assert_component_state(Primer::Beta::Flash, :beta)
  end
end
