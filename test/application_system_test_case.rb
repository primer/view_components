# frozen_string_literal: true

require "test_helper"
require "capybara/rails"
require "capybara/minitest"
require "capybara/cuprite"

Ferrum::Browser.new(process_timeout: 5)

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite, using: :chrome, screen_size: [1400, 1400]

  def with_preview(preview_name)
    component_uri = self.class.name.split("Integration").first.underscore

    visit("/rails/view_components/#{component_uri}/#{preview_name}")
  end
end
