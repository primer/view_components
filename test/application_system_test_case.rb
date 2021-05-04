# frozen_string_literal: true

require "test_helper"
require "capybara/rails"
require "capybara/minitest"

require "axe/configuration"
require 'axe/matchers/be_axe_clean'
require 'axe/expectation'

require "test_helpers/cuprite_setup"

Ferrum::Browser.new(process_timeout: 60, timeout: 60)

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite, using: :chrome, screen_size: [1400, 1400]

  def with_preview(preview_name)
    component_uri = self.class.name.gsub("Test", "").gsub("Integration", "").underscore

    visit("/rails/view_components/primer/#{component_uri}/#{preview_name}")

    assert_accessible(page, within: 'body')
  end

# Experimental override so accessibility checks are run after action

  def fill_in(locator, **kwargs)
    fill_in(locator, **kwargs)

    assert_accessible(page, within: 'body')
  end

  def click_button(locator, **kwargs)
    click_button(locator, **kwargs)

    assert_accessible(page, within: 'body')
  end

# Accessibility assertion

  def assert_accessible(page, **options)
    is_axe_clean = Axe::Matchers::BeAxeClean.new.tap do |a|
      options.each do |option|
        key, value = option
        a.send(key, value)
      end
    end

    Axe::AccessibleExpectation.new.assert page, is_axe_clean
  end

end
