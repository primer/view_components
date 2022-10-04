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
    puts "Saving #{component_uri}##{preview} snapshot."
  end

  def save_actions(component_uri, preview)
    page.driver.browser.css("button").each(&:click)
    page.save_screenshot(
      "#{component_uri}/actions/#{preview}/click.png",
      selector: "#component-preview"
    )
  end
end
