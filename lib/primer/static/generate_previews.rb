# frozen_string_literal: true

require "json"

module Primer
  module Static
    module GeneratePreviews
      class << self
        def call
          Lookbook.previews.filter_map do |preview|
            next if preview.preview_class.name.start_with?("Docs::")
            next if preview.preview_class == Primer::Forms::FormsPreview

            component = preview.components.first&.component_class

            unless component
              raise "Could not determine which component `#{preview.preview_class}` is designed to preview. Please add a `@component` annotation."
            end

            _, _, class_name = Primer::Yard::DocsHelper.status_module_and_short_name(component)

            {
              name: preview.name,
              component: class_name,
              status: component.status.to_s,
              lookup_path: preview.lookup_path,
              examples: preview.examples.map { |example|
                {
                  inspect_path: example.url_path,
                  preview_path: example.url_path.sub("/inspect/", "/preview/"),
                  name: example.name
                }
              }
            }
          end
        end
      end
    end
  end
end
