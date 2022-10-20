# frozen_string_literal: true

require "system/test_case"

class IntegrationLocalTimeComponentTest < System::TestCase
  def test_default
    visit_preview(:default)

    assert_selector("local-time[data-view-component]", text: "Wed Apr 2, 2014 8:30:00 AM GMT+8")
  end

  def test_with_all_the_options
    visit_preview(:with_all_the_options)

    assert_selector("local-time[data-view-component]", text: "Wednesday June 01, 16 09:05:07 PM Taipei Standard Time")
  end

  def test_with_contents
    visit_preview(:with_contents)

    assert_selector("local-time[data-view-component]", text: "Wed Apr 2, 2014 8:30:00 AM GMT+8")
  end
end
