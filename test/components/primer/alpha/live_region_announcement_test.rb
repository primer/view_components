# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaLiveRegionAnnouncementTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::LiveRegionAnnouncement.new)

    assert_selector("live-region")
  end
end
