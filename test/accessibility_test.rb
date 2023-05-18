# frozen_string_literal: true

require "system/test_case"

class AccessibilityTest < System::TestCase
  parallelize workers: 4

  Lookbook.previews.each do |preview|
    next if Primer::Accessibility.ignore_preview?(preview.preview_class)

    preview.scenarios.each do |parent_scenario|
      scenarios = parent_scenario.type == :scenario_group ? parent_scenario.scenarios : [parent_scenario]

      scenarios.each do |scenario|
        define_method(:"test_#{scenario.preview_path.parameterize(separator: "_")}") do
          visit scenario.preview_path

          excludes = Primer::Accessibility.axe_rules_to_skip(
            component: preview.components.first&.component_class,
            scenario_name: scenario.name
          )

          assert_accessible(excludes: excludes)

          puts "#{scenario.preview_path} passed check."
        end
      end
    end
  end
end
