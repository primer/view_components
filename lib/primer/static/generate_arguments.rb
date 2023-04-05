# frozen_string_literal: true

# :nocov:

require "json"

module Primer
  module Static
    # :nodoc:
    module GenerateArguments
      class << self
        def call(view_context: self.view_context)
          Primer::Component.descendants.sort_by(&:name).map do |component|
            docs = registry.find(component)
            ref = Primer::Yard::ComponentManifest.ref_for(component)

            args = docs.params.map do |tag|
              default_value = Primer::Yard::DocsHelper.pretty_default_value(tag, component)

              {
                "name" => tag.name,
                "type" => tag.types.join(", "),
                "default" => default_value,
                "description" => view_context.render(inline: tag.text.squish)
              }
            end

            {
              "component" => docs.metadata[:title],
              "status" => component.status.to_s,
              "a11y_reviewed" => docs.metadata[:a11y_reviewed] == "true",
              "short_name" => docs.short_name,
              "source" => ref.source_url,
              "lookbook" => ref.lookbook_url,
              "parameters" => args
            }
          end
        end

        private

        def view_context
          @view_context ||= ApplicationController.new.tap { |c| c.request = ActionDispatch::TestRequest.create }.view_context.tap do |vc|
            vc.singleton_class.include(Primer::Yard::DocsHelper)
            vc.singleton_class.include(Primer::ViewHelper)
          end
        end

        def registry
          @registry ||= Primer::Yard::Registry.make
        end
      end
    end
  end
end
