# frozen_string_literal: true

require "test_helper"

class PrimerTimelineItemBadgeComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_octicon
    render_inline(Primer::TimelineItem::BadgeComponent.new(icon: "star"))

    assert_selector(".TimelineItem-badge") do
      assert_selector(".octicon.octicon-star")
    end
  end
end
