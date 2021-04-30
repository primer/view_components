# frozen_string_literal: true

require "test_helper"
require "capybara/rails"
require "capybara/minitest"

require "test_helpers/cuprite_setup"

Ferrum::Browser.new(process_timeout: 60, timeout: 60)

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite, using: :chrome, screen_size: [1400, 1400]

  def with_preview(preview_name)
    component_uri = self.class.name.gsub("Test", "").gsub("Integration", "").underscore

    visit("/rails/view_components/primer/#{component_uri}/#{preview_name}")
  end
end
