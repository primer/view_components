# frozen_string_literal: true

require "system/test_helper"
require "capybara/rails"
require "capybara/minitest"

require "axe/matchers/be_axe_clean"
require "axe/expectation"

require "test_helpers/cuprite_setup"
require "test_helpers/retry"

module System
  class TestCase < ActionDispatch::SystemTestCase
    driven_by :cuprite, using: :chrome, screen_size: [1400, 1400], options: { process_timeout: 240, timeout: 240 }

    # Skip `:region` which relates to preview page structure rather than individual component.
    # Skip `:color-contrast` which requires primer design-level change.
    AXE_RULES_TO_SKIP = [:region, :"color-contrast"].freeze
    AXE_WITHIN_SELECTOR = "body"

    def visit_preview(preview_name)
      component_name = self.class.name.gsub("Test", "").gsub("Integration", "")
      match = /^(Alpha|Beta)([A-Z])/.match(component_name)
      status = match ? match[1] : ""
      status_path = match ? "#{status.downcase}/" : ""
      component_name = component_name.gsub(/^Beta|^Alpha/, "") if match
      component_uri = component_name.underscore

      visit("/rails/view_components/primer/#{status_path}#{component_uri}/#{preview_name}")

      assert_accessible(page)
    end

    def assert_accessible(page, within: AXE_WITHIN_SELECTOR, skipping: AXE_RULES_TO_SKIP, **options)
      options[:within] = within
      options[:skipping] = skipping

      is_axe_clean = Axe::Matchers::BeAxeClean.new.tap do |a|
        options.each do |option|
          key, value = option
          a.send(key, *value)
        end
      end

      Axe::AccessibleExpectation.new.assert page, is_axe_clean
    end

    # Capybara Overrides to run accessibility checks when UI changes.
    def fill_in(locator = nil, **kwargs)
      super

      assert_accessible(page)
    end

    def click_button(locator = nil, **kwargs)
      super

      assert_accessible(page)
    end
  end
end
