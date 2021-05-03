# frozen_string_literal: true

# First, load Cuprite Capybara integration
require "capybara/cuprite"
require 'axe/configuration'

# Then, we need to register our driver to be able to use it later
# with #driven_by method.
Capybara.register_driver(:cuprite) do |app|
  driver = Capybara::Cuprite::Driver.new(
    app,
    **{
      # Enable debugging capabilities
      inspector: true,
      # Allow running Chrome in a headful mode by setting HEADLESS env
      # var to a falsey value
      headless: !ENV["HEADLESS"].in?(%w[n 0 no false])
    }
  )

  AxeCuprite.configure(driver) do
  end

  driver
end

# Configure Capybara to use :cuprite driver by default
Capybara.default_driver = Capybara.javascript_driver = :cuprite

module AxeCuprite
  # configure method
  # - which takes an optional argument browser
  # - and a configuration block optional for Axe
  def self.configure(driver)
    # instantiate axe configuration (singleton) with defaults or given config
    if !block_given?
      raise Exception.new "Please provide a configure block for AxeCapybara"
    end

    config = Axe::Configuration.instance

    # provide a capybara webdriver page object
    config.page = driver

    # await and return
    yield config
    config
  end
end
