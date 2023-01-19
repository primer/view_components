# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaTimelineItemTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_an_empty_box
    render_inline(Primer::Beta::TimelineItem.new)

    refute_selector("div.TimelineItem")
    refute_selector(".TimelineItem-avatar")
    refute_selector(".TimelineItem-body")
    refute_selector(".TimelineItem-row")
    refute_selector(".TimelineItem-badge")
  end

  def test_defaults_to_not_condensed
    render_inline(Primer::Beta::TimelineItem.new) do |component|
      component.with_body { "Body" }
    end

    assert_selector("div.TimelineItem")
    refute_selector("div.TimelineItem--condensed")
  end

  def test_adds_condensed_modifier
    render_inline(Primer::Beta::TimelineItem.new(condensed: true)) do |component|
      component.with_body { "Body" }
    end

    assert_selector("div.TimelineItem")
    assert_selector("div.TimelineItem--condensed")
  end

  def test_avatar_defaults_to_square_and_size_40
    render_inline(Primer::Beta::TimelineItem.new) do |component|
      component.with_avatar(alt: "mock", src: "mock")
    end

    assert_selector(".TimelineItem-avatar")
    assert_selector(".avatar[size=40][width=40][height=40]")
    refute_selector(".circle")
  end

  def test_renders_circle_avatar
    render_inline(Primer::Beta::TimelineItem.new) do |component|
      component.with_avatar(alt: "mock", src: "mock", shape: :circle)
    end

    assert_selector(".TimelineItem-avatar")
    assert_selector(".avatar.circle")
  end

  def test_renders_avatar_with_custom_size
    render_inline(Primer::Beta::TimelineItem.new) do |component|
      component.with_avatar(alt: "mock", src: "mock", size: 20)
    end

    assert_selector(".TimelineItem-avatar")
    assert_selector(".avatar[size=20][width=20][height=20]")
  end

  def test_renders_body
    render_inline(Primer::Beta::TimelineItem.new) do |component|
      component.with_body { "Body" }
    end

    assert_selector(".TimelineItem-body", text: "Body")
  end

  def test_renders_badge
    render_inline(Primer::Beta::TimelineItem.new) do |component|
      component.with_badge(icon: :check)
    end

    assert_selector(".TimelineItem-badge")
  end

  def test_status
    assert_component_state(Primer::Beta::TimelineItem, :beta)
  end
end
