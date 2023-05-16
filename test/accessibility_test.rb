# frozen_string_literal: true

require "system/test_case"

class AccessibilityTest < System::TestCase
  parallelize workers: 4

  IGNORED_PREVIEWS = Primer::Accessibility::IGNORED_PREVIEWS

  ViewComponent::Preview.all.each do |klass|
    next if klass.name.start_with?("Docs::")
    next if IGNORED_PREVIEWS.include?(klass.to_s)

    component_previews = klass.instance_methods(false)
    component_uri = klass.to_s.underscore.gsub("_preview", "")

    component_previews.each do |preview|
      define_method(:"test_#{component_uri.parameterize(separator: "_")}_#{preview}") do
        visit("/rails/view_components/#{component_uri}/#{preview}")
        excludes = axe_rules_to_skip(component_name: klass.name.delete_prefix("Primer::").chomp("Preview"), preview_name: preview)
        assert_accessible(excludes: excludes)
        puts "#{component_uri}##{preview} passed check."
      end
    end
  end
end
