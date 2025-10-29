# frozen_string_literal: true

# First, load Cuprite Capybara integration
require "capybara/cuprite"

# Then, we need to register our driver to be able to use it later
# with #driven_by method.
Capybara.register_driver(:primer_cuprite) do |app|
  options = {
    process_timeout: 20,
    timeout: 10,
    # In case the timeout is not enough, this option can be activated:
    # pending_connection_errors: false,
    inspector: true,
    # Allow running Chrome in a headful mode by setting HEADLESS env
    # var to a falsey value
    headless: !ENV["HEADLESS"].in?(%w[n 0 no false]),
    # workaround for compatibility issues with browserless docker image and ferrum
    # see https://github.com/rubycdp/ferrum/issues/540
    flatten: false
  }

  browser_options = {
    "disable-dev-shm-usage": nil,
    "disable-gpu": nil,
    "disable-popup-blocking": nil,
    "no-sandbox": nil,
    "disable-smooth-scrolling": true,
    # Disable timers being throttled in background pages/tabs. Useful for
    # parallel test runs.
    "disable-background-timer-throttling": nil,
    # Normally, Chrome will treat a 'foreground' tab instead as backgrounded
    # if the surrounding window is occluded (aka visually covered) by another
    # window. This flag disables that. Useful for parallel test runs.
    "disable-backgrounding-occluded-windows": nil,
    # This disables non-foreground tabs from getting a lower process priority.
    # Useful for parallel test runs.
    "disable-renderer-backgrounding": nil
  }

  driver_options = options.merge(browser_options:)
  Capybara::Cuprite::Driver.new(app, **driver_options)
end

# Configure Capybara to use :cuprite driver by default
Capybara.default_driver = Capybara.javascript_driver = :cuprite
Capybara.save_path = "./test/snapshots"
Capybara.disable_animation = true
