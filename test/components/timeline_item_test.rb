# frozen_string_literal: true

require "test_helper"

class PrimerTimelineItemComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_an_empty_box
    render_inline(Primer::TimelineItemComponent.new)

    refute_selector("div.TimelineItem")
    refute_selector(".TimelineItem-avatar")
    refute_selector(".TimelineItem-body")
    refute_selector(".TimelineItem-row")
    refute_selector(".TimelineItem-badge")
  end

  def test_defaults_to_not_condensed
    render_inline(Primer::TimelineItemComponent.new) do |component|
      component.slot(:avatar) { "Avatar" }
    end

    assert_selector("div.TimelineItem")
    refute_selector("div.TimelineItem--condensed")
  end

  def test_adds_condensed_modifier
    render_inline(Primer::TimelineItemComponent.new(condensed: true)) do |component|
      component.slot(:avatar) { "Avatar" }
    end

    assert_selector("div.TimelineItem")
    assert_selector("div.TimelineItem--condensed")
  end

  def test_renders_avatar
    render_inline(Primer::TimelineItemComponent.new) do |component|
      component.slot(:avatar) { "Avatar" }
    end

    assert_selector(".TimelineItem-avatar", text: "Avatar")
  end

  def test_renders_body
    render_inline(Primer::TimelineItemComponent.new) do |component|
      component.slot(:body) { "Body" }
    end

    assert_selector(".TimelineItem-body", text: "Body")
  end

  def test_renders_badge
    render_inline(Primer::TimelineItemComponent.new) do |component|
      component.slot(:badge) { "Badge" }
    end

    assert_selector(".TimelineItem-badge", text: "Badge")
  end
end
