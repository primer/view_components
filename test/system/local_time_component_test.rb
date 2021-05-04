# frozen_string_literal: true

require "application_system_test_case"

class IntegrationLocalTimeComponentTest < ApplicationSystemTestCase
  def test_default
    with_preview(:default)

    assert_selector("local-time", text: "Wed Apr 2, 2014 1:30:00 AM")
  end

  def test_with_all_the_options
    with_preview(:with_all_the_options)

    assert_selector("local-time", text: "Wednesday June 01, 16 02:05:07 PM British Summer Time")
  end
end
