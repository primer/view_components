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
            next if preview.preview_class == Primer::FormsPreview
            next if Primer::Accessibility.ignore_preview?(preview.preview_class)

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
                  snapshot_tag = scenario.tags.find { |tag| tag.tag_name == "snapshot" }
                  snapshot = if snapshot_tag.nil?
                               "false"
                             elsif snapshot_tag.text.blank?
                               "true"
                             else
                               snapshot_tag.text
                             end
                  {
                    preview_path: scenario.lookup_path,
                    name: scenario.name,
                    snapshot: snapshot,
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
