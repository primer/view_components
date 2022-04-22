# frozen_string_literal: true

require "application_system_test_case"

class IntegrationDocExamplesAxeTest < ApplicationSystemTestCase
  # Skip components that should be tested as part of a larger component.
  # Do not add to this list for any other reason!
  NOT_STANDALONE = [:BetaAutoCompleteItemPreview, :NavigationTabComponentPreview, :ContentPreview, :AlphaActionMenuItemPreview].freeze
  IGNORE = [:MarkdownPreview].freeze

  def test_accessibility_of_doc_examples
    # Workaround to ensure that all component previews are loaded.
    visit("/rails/view_components")

    raise "You must generate previews with `bundle exec rake docs:preview` before running this test" unless defined? Primer::Docs

    puts "\n============================================================================="
    puts "Running axe-core checks on previews generated from documentation examples..."
    puts "============================================================================="

    Primer::Docs.constants.each do |klass|
      next if NOT_STANDALONE.include?(klass)
      next if IGNORE.include?(klass)

      component_previews = Primer::Docs.const_get(klass).instance_methods(false)
      component_uri = klass.to_s.underscore.gsub("_preview", "")
      component_previews.each do |preview|
        visit("/rails/view_components/primer/docs/#{component_uri}/#{preview}")
        begin
          assert_accessible(page)
        rescue RuntimeError => e
          # :nocov:
          puts "=========================================================================="
          puts "#{component_uri}##{preview} failed check."
          puts "=========================================================================="
          raise e
          # :nocov:
        else
          puts "#{component_uri}##{preview} passed check."
        end
      end
    end
  end
end
