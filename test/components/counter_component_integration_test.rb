# frozen_string_literal: true

require "application_system_test_case"

class CounterComponentIntegrationTest < ApplicationSystemTestCase
  def test_integration
    visit("/rails/view_components/counter_component/default")

    assert_selector(".Counter", text: "2")
  end
end
