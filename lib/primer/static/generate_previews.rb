# frozen_string_literal: true

# :nocov:

require "json"

module Primer
  module Static
    # :nodoc:
    module GeneratePreviews
      class << self
        def call
          Lookbook.previews.filter_map do |preview|
            next if preview.preview_class.name.start_with?("Docs::")
            next if preview.preview_class == Primer::Forms::FormsPreview
            next if Primer::Accessibility::IGNORED_PREVIEWS.include?(preview.preview_class.name)

            component = preview.components.first&.component_class

            # rubocop:disable Style/IfUnlessModifier
            unless component
              raise "Could not determine which component `#{preview.preview_class}` is designed to preview. Please add a `@component` annotation."
            end
            # rubocop:enable Style/IfUnlessModifier

            _, _, class_name = Primer::Yard::DocsHelper.status_module_and_short_name(component)

            {
              name: preview.name,
              component: class_name,
              status: component.status.to_s,
              lookup_path: preview.lookup_path,
              examples: preview.scenarios.flat_map do |parent_scenario|
                scenarios = parent_scenario.type == :scenario_group ? parent_scenario.scenarios : [parent_scenario]

                scenarios.map do |scenario|
                  {
                    preview_path: "/view-components/rails-app/previews/#{scenario.lookup_path}",
                    # preview_path: "/rails/view_components/#{scenario.lookup_path}",
                    name: scenario.name,
                    skip_rules: Primer::Accessibility.axe_rules_to_skip(
                      component: component,
                      scenario_name: scenario.name
                    )
                  }
                end
              end
            }
          end
        end
      end
    end
  end
end
