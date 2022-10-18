# frozen_string_literal: true

require "components/test_helper"

class SubheadComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_without_heading
    render_inline(Primer::SubheadComponent.new)

    refute_component_rendered
  end

  def test_renders_heading
    render_inline(Primer::SubheadComponent.new) do |component|
      component.heading(tag: :h2) { "Hello World" }
    end

    assert_selector(".Subhead h2.Subhead-heading", text: "Hello World")
  end

  def test_heading_tag_falls_back_to_default
    without_fetch_or_fallback_raises do
      render_inline(Primer::SubheadComponent.new) do |component|
        component.heading(tag: :span) { "Hello World" }
      end
    end

    assert_selector("div.Subhead-heading", text: "Hello World")
  end

  def test_render_dangerous_heading
    render_inline(Primer::SubheadComponent.new) do |component|
      component.heading(danger: true) { "Hello World" }
    end

    assert_selector(".Subhead .Subhead-heading--danger", text: "Hello World")
  end

  def test_render_without_border
    render_inline(Primer::SubheadComponent.new(hide_border: true)) do |component|
      component.heading { "Hello World" }
    end

    assert_selector(".Subhead.border-bottom-0.mb-0", text: "Hello World")
  end

  def test_bottom_margin_can_be_overridden_when_border_is_hidden
    render_inline(Primer::SubheadComponent.new(hide_border: true, mb: 1)) do |component|
      component.heading { "Hello World" }
    end

    assert_selector(".Subhead.border-bottom-0.mb-1", text: "Hello World")
  end

  def test_renders_actions
    render_inline(Primer::SubheadComponent.new(heading: "Hello world")) do |component|
      component.heading { "Hello World" }
      component.actions { "My Actions" }
    end

    assert_selector(".Subhead .Subhead-actions", text: "My Actions")
  end

  def test_handles_spacious
    render_inline(Primer::SubheadComponent.new(spacious: true)) do |component|
      component.heading { "Hello World" }
    end

    assert_selector(".Subhead.Subhead--spacious .Subhead-heading", text: "Hello World")
  end

  def test_renders_a_description
    render_inline(Primer::SubheadComponent.new(heading: "Hello world")) do |component|
      component.heading { "Hello World" }
      component.description { "My Description" }
    end

    assert_selector(".Subhead .Subhead-description", text: "My Description")
  end

  def test_status
    assert_component_state(Primer::SubheadComponent, :beta)
  end
end
