# frozen_string_literal: true

require "application_system_test_case"

class IntegrationAlphaLiveRegionAnnouncementTest < ApplicationSystemTestCase
  def test_renders_component
    visit_preview(:default)

    assert_selector("live-region")
  end
end
