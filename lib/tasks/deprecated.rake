# frozen_string_literal: true

namespace :deprecated do
  task :check do
    require_relative "./../primer/view_components/linters/helpers/deprecated_components_helpers"
    require_relative "../primer/view_components/statuses"

    puts "Checking that officially deprecated components are linted by `DeprecatedComponents` linter...."

    if Primer::ViewComponents::STATUSES.select { |_, value| value == "deprecated" }.keys.sort != ERBLint::Linters::Helpers::DeprecatedComponentsHelpers::COMPONENT_TO_USE_INSTEAD.keys.sort
      puts "\n**************************************************************************************************************************"
      raise "Please make sure that components are officially deprecated by setting the `status :deprecated` within the component file.\n"\
      "Run `bundle exec rake static:dump` so the deprecated status is reflected in `statuses.json`.\n"\
      "Make sure to provide an alternative component for each deprecated component in `Primer::Deprecations::DEPRECATED_COMPONENTS` (lib/primer/deprecations.rb).\n"\
      "If there is no alternative to suggest, set the value to nil."
    end

    puts "\n============================================================================="
    puts "All good!"
    puts "============================================================================="
  end
end
