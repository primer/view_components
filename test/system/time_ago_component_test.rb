# frozen_string_literal: true

require "system/test_case"

class IntegrationTimeAgoComponentTest < System::TestCase
  def test_render
    visit_preview(:default)

    assert_selector("time-ago[data-view-component]", text: "now")
  end

  def test_render_micro
    visit_preview(:micro)

    assert_selector("time-ago[data-view-component]", text: "1m")
  end
end
