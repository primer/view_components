# frozen_string_literal: true

require "application_system_test_case"

class IntegrationDocExamplesTest < ApplicationSystemTestCase
  # Part of a larger component and should not be tested alone.
  NON_STANDALONE=[:ItemPreview].freeze

  WITH_PRIMER_FUNCTION=[:ImagePreview, :OcticonComponentPreview, :ImageCropPreview].freeze
  
  # Starting point violations which should be addressed.
  STARTING_POINT_VIOLATIONS=[:MarkdownPreview, :AutoCompletePreview, :TabComponentPreview].freeze
  
  def test_accessibility
    puts "========================================================="
    puts "Running axe-core checks on documentation examples"
    puts "========================================================="

    Primer::Docs.constants.each do |klass|
      next if NON_STANDALONE.include?(klass) || STARTING_POINT_VIOLATIONS.include?(klass)
      
      component_previews = Primer::Docs.const_get(klass).instance_methods(false)
      component_uri = klass.to_s.underscore.gsub("_preview", "")
      component_previews.each do |preview|
        visit("/rails/view_components/primer/docs/#{component_uri}/#{preview}")
        begin 
          assert_accessible(page)
        rescue RuntimeError => e
          puts "###########################################"
          puts "#{component_uri}##{preview} failed axe check."
          raise e
          puts "###########################################"
        else
          puts "#{component_uri}##{preview} passed axe check."
        end
      end
    end
    puts "========================================================="
    puts "The following previews contain known axe violations."
    puts "Please open a fix for them:"
    puts STARTING_POINT_VIOLATIONS.join("\n")
    puts "========================================================="
  end
end
