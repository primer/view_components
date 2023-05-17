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
            skip_rules = Primer::Accessibility.axe_rules_to_skip(component: component, preview_name: preview.name)

            {
              name: preview.name,
              component: class_name,
              status: component.status.to_s,
              lookup_path: preview.lookup_path,
              skip_rules: skip_rules,
              examples: preview.examples.map do |example|
                {
                  inspect_path: example.url_path,
                  preview_path: example.url_path.sub("/inspect/", "/preview/"),
                  name: example.name
                }
              end
            }
          end
        end
      end
    end
  end
end
