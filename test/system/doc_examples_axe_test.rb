# frozen_string_literal: true

require "application_system_test_case"
require "yard/docs_preview_generator"

class IntegrationDocExamplesAxeTest < ApplicationSystemTestCase
  # Skip components that should be tested as part of a larger component.
  NOT_STANDALONE = [:AutoCompleteItemPreview].freeze

  # Starting point violations to be addressed. Do not add to this list!
  STARTING_POINT_VIOLATIONS = [:MarkdownPreview, :AutoCompletePreview, :TabComponentPreview, :NavigationTabComponentPreview].freeze

  def test_accessibility_of_doc_examples
    # Generate previews
    YARD::DocsPreviewGenerator.call

    puts "\n============================================================================="
    puts "Running axe-core checks on previews generated from documentation examples..."
    puts "============================================================================="

    # Workaround to ensure that all component previews are loaded.
    visit("/rails/view_components")

    Primer::Docs.constants.each do |klass|
      next if NOT_STANDALONE.include?(klass) || STARTING_POINT_VIOLATIONS.include?(klass)

      component_previews = Primer::Docs.const_get(klass).instance_methods(false)
      component_uri = klass.to_s.underscore.gsub("_preview", "")
      component_previews.each do |preview|
        visit("/rails/view_components/primer/docs/#{component_uri}/#{preview}")
        begin
          assert_accessible(page)
        rescue RuntimeError => e
          puts "=========================================================================="
          puts "#{component_uri}##{preview} failed check."
          puts "=========================================================================="
          raise e
        else
          puts "#{component_uri}##{preview} passed check."
        end
      end
    end
    puts "=========================================================================="
    puts "The following component previews contain axe violation. Please open a fix for them:"
    puts STARTING_POINT_VIOLATIONS.join("\n")
    puts "=========================================================================="
  end
end
