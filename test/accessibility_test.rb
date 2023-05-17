# frozen_string_literal: true

require "system/test_case"

class AccessibilityTest < System::TestCase
  parallelize workers: 4

  IGNORED_PREVIEWS = Primer::Accessibility::IGNORED_PREVIEWS

  Lookbook.previews.each do |preview|
    next if preview.preview_class.name.start_with?("Docs::")
    next if IGNORED_PREVIEWS.include?(preview.preview_class.name)
    next unless preview.preview_class == Primer::Alpha::LayoutPreview

    preview.examples.each do |parent_example|
      define_method(:"test_#{example.preview_path.parameterize(separator: "_")}_#{preview.name}") do
        visit("/rails/view_components/#{example.preview_path}")

        excludes = Primer::Accessibility.axe_rules_to_skip(
          component: preview.components.first&.component_class,
          preview_name: preview.name
        )

        assert_accessible(excludes: excludes)
        puts "#{example.preview_path}##{preview.name} passed check."
      end
    end
  end
end
