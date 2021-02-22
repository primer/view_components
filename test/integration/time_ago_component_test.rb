# frozen_string_literal: true

require "application_system_test_case"

class IntegrationTimeAgoComponentTest < ApplicationSystemTestCase
  def test_render
    with_preview(:default)

    assert_selector("time-ago", text: "now")
  end

  def test_render_micro
    with_preview(:micro)

    assert_selector("time-ago", text: "1m")
  end
end
