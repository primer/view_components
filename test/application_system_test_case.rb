# frozen_string_literal: true

require "test_helper"
require "capybara/rails"
require "capybara/minitest"
require "capybara/cuprite"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite, using: :chrome, screen_size: [1400, 1400]
end
