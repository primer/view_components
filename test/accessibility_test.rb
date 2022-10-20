# frozen_string_literal: true

require "system/test_case"

class AccessibilityTest < System::TestCase
  # Skip components that should be tested as part of a larger component.
  # Do not add to this list for any other reason!
  IGNORED_PREVIEWS = %w[
    Primer::MarkdownPreview
    Primer::Beta::AutoCompleteItemPreview
    Docs::BetaAutoCompleteItemPreview
    Docs::NavigationTabComponentPreview
  ].freeze

  def test_accessibility_of_doc_examples
    # Workaround to ensure that all component previews are loaded.
    visit("/rails/view_components")

    puts "\n============================================================================="
    puts "Running axe-core checks on previews..."
    puts "============================================================================="

    failure_urls = []

    components = ViewComponent::Preview.descendants
    components.each do |klass|
      next if IGNORED_PREVIEWS.include?(klass.to_s)

      component_previews = klass.instance_methods(false)
      component_uri = klass.to_s.underscore.gsub("_preview", "")
      component_previews.each do |preview|
        visit("/rails/view_components/#{component_uri}/#{preview}")
        begin
          assert_accessible(page)
        rescue RuntimeError => e
          # :nocov:
          puts "=========================================================================="
          puts e.to_s
          puts "#{component_uri}##{preview} failed check."
          puts "=========================================================================="
          failure_urls.push("#{component_uri}/#{preview}")

          # :nocov:
        else
          puts "#{component_uri}##{preview} passed check."
        end
      end
    end

    raise "#{failure_urls.count} components had axe failures:\n#{failure_urls}" if failure_urls.any?
  end
end
