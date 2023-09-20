# frozen_string_literal: true

require "components/test_helper"

class PrimerBannerTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::Alpha::Banner.new) { "foo" }

    assert_selector(".Banner")
    assert_selector(".Banner-message", text: "foo")
    refute_selector(".Banner-close")
    refute_selector(".Banner--error")
    refute_selector(".Banner--warning")
    refute_selector(".Banner--success")
    refute_selector(".Banner--full")
    refute_selector(".Banner--fullWhenNarrow")
    assert_selector(".octicon")
  end

  def test_includes_legacy_classes
    render_inline(Primer::Alpha::Banner.new) { "foo" }

    assert_selector(".flash")
  end

  def test_renders_danger_scheme
    render_inline(Primer::Alpha::Banner.new(scheme: :danger)) { "foo" }

    assert_selector(".Banner.Banner--error", text: "foo")
    assert_selector(".flash.flash-error", text: "foo") # legacy
  end

  def test_renders_warning_scheme
    render_inline(Primer::Alpha::Banner.new(scheme: :warning)) { "foo" }

    assert_selector(".Banner.Banner--warning", text: "foo")
    assert_selector(".flash.flash-warn", text: "foo") # legacy
  end

  def test_renders_success_scheme
    render_inline(Primer::Alpha::Banner.new(scheme: :success)) { "foo" }

    assert_selector(".Banner.Banner--success", text: "foo")
    assert_selector(".flash.flash-success", text: "foo") # legacy
  end

  def test_renders_default_icon
    render_inline(Primer::Alpha::Banner.new) { "foo" }

    assert_selector(".octicon.octicon-bell")
  end

  def test_renders_default_danger_icon
    render_inline(Primer::Alpha::Banner.new(scheme: :danger)) { "foo" }

    assert_selector(".octicon.octicon-stop")
  end

  def test_renders_default_warning_icon
    render_inline(Primer::Alpha::Banner.new(scheme: :warning)) { "foo" }

    assert_selector(".octicon.octicon-alert")
  end

  def test_renders_default_success_icon
    render_inline(Primer::Alpha::Banner.new(scheme: :success)) { "foo" }

    assert_selector(".octicon.octicon-check-circle")
  end

  def test_uses_default_if_scheme_does_not_exist
    without_fetch_or_fallback_raises do
      render_inline(Primer::Alpha::Banner.new(scheme: :zombieratsfromouterspace)) { "foo" }

      assert_selector(".Banner", text: "foo")
      refute_selector(".Banner--error")
      refute_selector(".Banner--warning")
      refute_selector(".Banner--success")
    end
  end

  def test_renders_full_width
    render_inline(Primer::Alpha::Banner.new(full: true)) { "foo" }

    assert_selector(".Banner.Banner--full", text: "foo")
    assert_selector(".flash.flash-full", text: "foo") # legacy
  end

  def test_renders_full_width_when_narrow
    render_inline(Primer::Alpha::Banner.new(full_when_narrow: true)) { "foo" }

    assert_selector(".Banner.Banner--full-whenNarrow", text: "foo")
  end

  def test_renders_custom_icon
    render_inline(Primer::Alpha::Banner.new(icon: :alert)) { "foo" }

    assert_selector(".Banner .octicon.octicon-alert")
  end

  def test_renders_dismiss_button
    render_inline(Primer::Alpha::Banner.new(dismiss_scheme: :remove)) { "foo" }

    assert_selector(".Banner .Banner-close")
  end

  def test_does_not_render_dismiss_button
    render_inline(Primer::Alpha::Banner.new(dismiss_scheme: :none)) { "foo" }

    refute_selector(".Banner-close")
  end

  def test_renders_action_button_slot
    render_inline(Primer::Alpha::Banner.new) do |component|
      component.with_action_button { "submit" }
    end

    assert_selector(".Banner .Banner-actions", text: "submit")
  end

  def test_renders_arbitrary_action_content
    render_inline(Primer::Alpha::Banner.new) do |component|
      component.with_action_content do
        "<p class='foo'>Custom content</p>".html_safe
      end
    end

    assert_selector(".Banner .Banner-actions p.foo", text: "Custom content")
  end

  def test_status
    assert_component_state(Primer::Alpha::Banner, :alpha)
  end
end
