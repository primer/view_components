# frozen_string_literal: true

require "application_system_test_case"

class CounterComponentIntegrationTest < ApplicationSystemTestCase
  def test_integration
    with_preview(:default)

    assert_selector(".Counter", text: "2")
  end
end
