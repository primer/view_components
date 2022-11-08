# frozen_string_literal: true

require "system/test_case"

class IntegrationTimeAgoComponentTest < System::TestCase
  def test_render
    visit_preview(:default)

    assert_selector("relative-time[data-view-component][tense='past']")
  end

  def test_render_micro
    visit_preview(:micro)

    assert_selector("relative-time[data-view-component][tense='past'][format='micro']")
  end
end
