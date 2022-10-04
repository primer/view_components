# frozen_string_literal: true

require "application_system_test_case"

class SnapshotsTest < ApplicationSystemTestCase
  def test_accessibility_of_doc_examples
    # Workaround to ensure that all component previews are loaded.
    visit("/rails/view_components")

    components = ViewComponent::Preview.descendants
    components.each do |klass|
      component_previews = klass.instance_methods(false)
      component_uri = klass.to_s.underscore.gsub("_preview", "")
      component_previews.each do |preview|
        visit("/rails/view_components/#{component_uri}/#{preview}")
        page.driver.zoom_factor = 1
        page.driver.resize_window(1024, 1400)

        puts "Saving #{component_uri}##{preview} snapshots."

        save_default(component_uri, preview)
        save_actions(component_uri, preview)
      end
    end
  end

  private

  def save_default(component_uri, preview)
    page.save_screenshot(
      "#{component_uri}/#{preview}.png",
      selector: "#component-preview"
    )
  end

  def save_actions(component_uri, preview)
    # focus first element
    page.driver.browser.keyboard.type(:tab)
    element = page.driver.browser.evaluate("document.activeElement")

    # When nothing is active, the element will be the body
    return if ["body"].include? element.tag_name

    begin
      page.save_screenshot(
        "#{component_uri}/actions/#{preview}/focus.png",
        selector: "#component-preview"
      )

      # We only want to press enter on buttons
      return unless ["button"].include? element.tag_name

      page.driver.browser.keyboard.type(:enter)
      page.save_screenshot(
        "#{component_uri}/actions/#{preview}/enter.png",
        selector: "#component-preview"
      )
    rescue Ferrum::BrowserError => e
      puts "Error: #{e.message}"
    end
  end
end
