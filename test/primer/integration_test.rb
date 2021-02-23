# frozen_string_literal: true

require "application_system_test_case"

class IntegrationTest < ApplicationSystemTestCase
  def test_integration
    visit("/")

    assert_selector(".Counter", text: "2")
  end
end
