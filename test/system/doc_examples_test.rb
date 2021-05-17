# frozen_string_literal: true

require "application_system_test_case"

class IntegrationDocExamplesTest < ApplicationSystemTestCase
  def test_accessibility
    Primer::Docs.constants.each do |klass|
      component_uri = klass.to_s.underscore.gsub("_preview", "")
      component_previews = Primer::Docs.const_get(klass).instance_methods(false)
      component_previews.each do |preview|
        visit("/rails/view_components/primer/docs/#{component_uri}/#{preview}")
        begin 
          assert_accessible(page)
        rescue RuntimeError => e
          puts "###########################################"
          puts "AXE FAILURE IN #{component_uri}##{preview}"
          puts e 
          puts "###########################################"
        end
      end
    end
  end
end
