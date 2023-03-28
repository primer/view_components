# frozen_string_literal: true

require "json"

module Primer
  module Static
    module GenerateInfoArch
      class << self
        def call
          component_docs = Primer::Component.descendants.sort_by(&:name).each_with_object({}) do |component, memo|
            docs = registry.find(component)

            preview_data = previews.find do |preview|
              preview["component"] == docs.metadata[:title] &&
                preview["status"] == component.status.to_s
            end

            arg_data = args.find do |component_args|
              component_args["component"] == docs.metadata[:title] &&
                component_args["status"] == component.status.to_s
            end

            slots = docs.slot_methods.map do |slot_method|
              param_tags = slot_method.tags(:param)

              slot_args = param_tags.map do |tag|
                default_value = Primer::Yard::DocsHelper.pretty_default_value(tag, component)

                {
                  "name" => tag.name,
                  "type" => tag.types.join(", "),
                  "default" => default_value,
                  "description" => view_context.render(inline: tag.text.squish)
                }
              end

              {
                "name" => slot_method.name,
                "description" => if slot_method.base_docstring.to_s.present?
                  view_context.render(inline: slot_method.base_docstring)
                end,
                "parameters" => slot_args
              }
            end

            description = if component == Primer::BaseComponent
              docs.base_docstring
            else
              view_context.render(inline: docs.base_docstring)
            end

            memo[component] = {
              "fully_qualified_name" => component.name,
              "description" => description,
              **arg_data,
              "slots" => slots,
              "previews" => (preview_data || {}).fetch("examples", []),
              "subcomponents" => []
            }
          end

          statuses = Primer::Status::Dsl::STATUSES.keys.map(&:to_s).map(&:capitalize)

          Primer::Component.descendants.each do |component|
            fq_class = component.name.to_s.split("::")
            fq_class.shift # remove Primer::
            status = fq_class.shift if statuses.include?(fq_class.first) # remove Status::

            parent, *child = *fq_class

            next if child.empty?

            parent_class = Primer
            parent_class = parent_class.const_get(status) if status
            parent_class = parent_class.const_get(parent)

            parent_docs = component_docs[parent_class]
            next unless parent_docs

            if (child_docs = component_docs.delete(component))
              parent_docs["subcomponents"] << child_docs
            end
          end

          component_docs.values
        end

        private

        def previews
          @previews ||= JSON.parse(Static.read(:previews))
        end

        def args
          @args ||= JSON.parse(Static.read(:arguments))
        end

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
