# frozen_string_literal: true

# allow downloading geckodriver automatically
WebMock.enable_net_connect!

require "selenium-webdriver"
require "webdrivers/geckodriver"

WebMock.disable_net_connect!(allow_localhost: true)

Capybara.register_driver(:primer_webdriver) do |app|
  options = Selenium::WebDriver::Firefox::Options.new
  options.add_preference("devtools.jsonview.enabled", false)
  options.add_argument("--headless") if !ENV["HEADLESS"].in?(%w[n 0 no false])

  Capybara::Selenium::Driver.new(
    app,
    browser: :firefox,
    options: options
  )
end

Capybara.default_driver = Capybara.javascript_driver = :primer_webdriver
Capybara.save_path = "./test/snapshots"
Capybara.disable_animation = true
