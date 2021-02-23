# frozen_string_literal: true

require "application_system_test_case"

class CounterComponentIntegrationTest < ApplicationSystemTestCase
  def test_integration
    with_preview(:default)

    assert_selector(".Counter", text: "2")
  end

  def with_preview(preview_name)
    component_uri = self.class.name.split("Integration").first.underscore

    visit("/rails/view_components/#{component_uri}/#{preview_name}")
  end
end
