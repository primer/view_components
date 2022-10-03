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
        begin
          page.driver.zoom_factor = 1
          page.save_screenshot(
            "#{component_uri}/#{preview}.png",
            selector: "#component-preview",
            window_size: [1056, 800]
          )
        rescue Ferrum::BrowserError
          next
        else
          puts "Saving #{component_uri}##{preview} snapshot."
        end
      end
    end
  end
end
