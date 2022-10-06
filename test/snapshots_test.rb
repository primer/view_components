# frozen_string_literal: true

require "application_system_test_case"

class SnapshotsTest < ApplicationSystemTestCase
  def test_take_snapshots_of_all_components
    # Workaround to ensure that all component previews are loaded.
    visit("/rails/view_components")

    components = ViewComponent::Preview.descendants
    components.each do |klass|
      component_previews = klass.instance_methods(false)
      component_uri = klass.to_s.underscore.gsub("_preview", "")
      component_previews.each do |preview|
        next unless preview.to_s == "default"

        page_url = "#{component_uri}/#{preview}"
        page.driver.zoom_factor = 1
        puts "Saving #{page_url} snapshots."

        visit("/rails/view_components/#{page_url}")

        # Add some css to try and stop the page from moving around
        page.driver.browser.add_style_tag(path: File.join(File.dirname(__FILE__), "./snapshot.css"))
        page.driver.resize_window(1024, 1400)

        page.save_screenshot(
          "#{page_url}/light.jpeg",
          selector: "#component-preview"
        )
        save_actions(page_url)
      end
    end
  end

  private

  def save_actions(page_url)
    # focus first element
    page.driver.browser.keyboard.type(:tab)
    element = page.driver.browser.evaluate("document.activeElement")

    # When nothing is active, the element will be the body
    return if ["body"].include? element.tag_name

    begin
      page.save_screenshot(
        "#{page_url}/focus.jpeg",
        selector: "#component-preview"
      )

      # We only want to press enter on buttons
      return unless %w[button summary].include? element.tag_name

      page.driver.resize_window(1024, 375)

      page.driver.browser.keyboard.type(:enter)
      page.save_screenshot("#{page_url}/enter.jpeg")
    rescue Ferrum::BrowserError => e
      puts "Error: #{e.message}"
    end
  end
end
