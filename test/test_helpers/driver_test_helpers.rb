# frozen_string_literal: true

module Primer
  module DriverTestHelpers
    def chrome?
      browser == "chrome"
    end

    def firefox?
      browser == "firefox"
    end

    def driver_name
      chrome? ? :primer_cuprite : :primer_webdriver
    end

    def setup_driver
      if chrome?
        require "test_helpers/cuprite_setup"
      elsif firefox?
        require "test_helpers/webdriver_setup"
      end

      require "test_helpers/retry"
    end

    private

    def browser
      ENV.fetch("USE_BROWSER", "chrome")
    end

    extend(self)
  end
end
