# frozen_string_literal: true

require "system/test_case"

class SnapshotsTest < System::TestCase
  def test_accessibility_of_doc_examples
    # Workaround to ensure that all component previews are loaded.
    visit("/rails/view_components")

    components = ViewComponent::Preview.descendants
    components.each do |klass|
      component_previews = klass.instance_methods(false)
      component_uri = klass.to_s.underscore.gsub("_preview", "")
      component_previews.each do |preview|
        page_url = "#{component_uri}/#{preview}"

        puts "Saving #{page_url} snapshots."

        themes = %w[
          light
        ]

        themes.each do |theme|
          visit("/rails/view_components/#{page_url}?theme=#{theme}")
          page.driver.zoom_factor = 1
          page.driver.resize_window(1024, 1400)

          page.save_screenshot(
            "#{page_url}/#{theme}/initial.png",
            selector: "#component-preview"
          )
          save_actions("#{page_url}/#{theme}")
        end
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
        "#{page_url}/focus.png",
        selector: "#component-preview"
      )

      # We only want to press enter on buttons
      return unless ["button"].include? element.tag_name

      page.driver.resize_window(1024, 375)

      page.driver.browser.keyboard.type(:enter)
      page.save_screenshot("#{page_url}/enter.png")
    rescue Ferrum::BrowserError => e
      puts "Error: #{e.message}"
    end
  end
end
