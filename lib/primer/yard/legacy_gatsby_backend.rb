# frozen_string_literal: true

require "primer/yard/component_manifest"
require "primer/yard/backend"

module Primer
  module YARD
    class LegacyGatsbyBackend < Backend
      class << self
        def parse_example_tag(tag)
          name = tag.name
          description = nil
          code = nil

          if tag.text.include?("@description")
            splitted = tag.text.split(/@description|@code/)
            description = splitted.second.gsub(/^[ \t]{2}/, "").strip
            code = splitted.last.gsub(/^[ \t]{2}/, "").strip
          else
            code = tag.text
          end

          [name, description, code]
        end
      end

      attr_reader :registry

      def initialize(registry)
        @registry = registry
      end

      def generate
        args_for_components = []
        errors = []

        each_component do |component|
          docs = registry.find(component)
          status_path = docs.status_module.nil? ? "" : "#{docs.status_module}/"

          metadata = docs.metadata.merge(
            source: source_url(component),
            lookbook: lookbook_url(component),
            path: "docs/content/components/#{status_path}#{docs.short_name.downcase}.md",
            example_path: example_path(component),
            require_js_path: require_js_path(component)
          )

          path = Pathname.new(metadata[:path])
          path.dirname.mkpath unless path.dirname.exist?

          File.open(path, "w") do |f|
            f.puts("---")
            f.puts("title: #{metadata[:title]}")
            f.puts("componentId: #{metadata[:component_id]}")
            f.puts("status: #{metadata[:status]}")
            f.puts("source: #{metadata[:source]}")
            f.puts("a11yReviewed: #{metadata[:a11y_reviewed]}")
            f.puts("lookbook: #{metadata[:lookbook]}") if preview_exists?(component)
            f.puts("---")
            f.puts
            f.puts("import Example from '#{metadata[:example_path]}'")

            if docs.requires_js?
              f.puts("import RequiresJSFlash from '#{metadata[:require_js_path]}'")
              f.puts
              f.puts("<RequiresJSFlash />")
            end

            f.puts
            f.puts("<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->")
            f.puts
            f.puts(view_context.render(inline: docs.base_docstring))

            if docs.tags(:deprecated).any?
              f.puts
              f.puts("## Deprecation")
              docs.tags(:deprecated).each do |tag|
                f.puts
                f.puts view_context.render(inline: tag.text)
              end
            end

            if docs.tags(:accessibility).any?
              f.puts
              f.puts("## Accessibility")
              docs.tags(:accessibility).each do |tag|
                f.puts
                f.puts view_context.render(inline: tag.text)
              end
            end

            errors << { component.name => { arguments: "No argument documentation found" } } unless docs.params.any?

            f.puts
            f.puts("## Arguments")
            f.puts
            f.puts("| Name | Type | Default | Description |")
            f.puts("| :- | :- | :- | :- |")

            documented_params = docs.params.map(&:name)
            component_params = component.instance_method(:initialize).parameters.map { |p| p.last.to_s }

            if (documented_params & component_params).size != component_params.size
              err = { arguments: {} }
              (component_params - documented_params).each do |arg|
                err[:arguments][arg] = "Not documented"
              end

              errors << { component.name => err }
            end

            args = []
            docs.params.each do |tag|
              default_value = pretty_default_value(tag, component)

              args << {
                "name" => tag.name,
                "type" => tag.types.join(", "),
                "default" => default_value,
                "description" => view_context.render(inline: tag.text.squish)
              }

              f.puts("| `#{tag.name}` | `#{tag.types.join(', ')}` | #{default_value} | #{view_context.render(inline: tag.text.squish)} |")
            end

            component_args = {
              "component" => metadata[:title],
              "status" => component.status.to_s,
              "source" => metadata[:source],
              "lookbook" => metadata[:lookbook],
              "parameters" => args
            }

            args_for_components << component_args

            if docs.slot_methods.any?
              f.puts
              f.puts("## Slots")

              docs.slot_methods.each do |slot_docs|
                emit_method(slot_docs, component, f)
              end
            end

            example_tags = docs.constructor.tags(:example)

            if example_tags.any?
              f.puts
              f.puts("## Examples")

              example_tags.each do |tag|
                name, description, code = parse_example_tag(tag)
                f.puts
                f.puts("### #{name}")
                if description
                  f.puts
                  f.puts(view_context.render(inline: description.squish))
                end
                f.puts
                html = view_context.render(inline: code)
                f.puts("<Example src=\"#{html.tr('"', "\'").delete("\n")}\" />")
                f.puts
                f.puts("```erb")
                f.puts(code.to_s)
                f.puts("```")
              end
            else
              if manifest.components_with_examples.include?(component)
                errors << { component.name => { example: "No examples found" } }
              end
            end
          end
        end

        # Build system arguments docs from BaseComponent
        system_args_docs = registry.find(Primer::BaseComponent)

        File.open("docs/content/system-arguments.md", "w") do |f|
          f.puts("---")
          f.puts("title: System arguments")
          f.puts("---")
          f.puts
          f.puts("<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->")
          f.puts
          f.puts(system_args_docs.base_docstring)
          f.puts

          f.puts(view_context.render(inline: system_args_docs.constructor.base_docstring))
        end

        [args_for_components, errors]
      end

      private

      def emit_method(method_docs, component, f)
        f.puts
        f.puts("### `#{method_docs.name}`")

        if method_docs.base_docstring.to_s.present?
          f.puts
          f.puts(view_context.render(inline: method_docs.base_docstring))
        end

        param_tags = method_docs.tags(:param)
        if param_tags.any?
          f.puts
          f.puts("| Name | Type | Default | Description |")
          f.puts("| :- | :- | :- | :- |")
        end

        param_tags.each do |tag|
          f.puts("| `#{tag.name}` | `#{tag.types.join(', ')}` | #{pretty_default_value(tag, component)} | #{view_context.render(inline: tag.text)} |")
        end
      end

      def each_component(&block)
        manifest.components_with_docs.sort_by(&:name).each(&block)
      end

      def manifest
        Primer::YARD::ComponentManifest
      end

      def source_url(component)
        path = component.name.split("::").map(&:underscore).join("/")

        "https://github.com/primer/view_components/tree/main/app/components/#{path}.rb"
      end

      def lookbook_url(component)
        path = component.name.underscore.gsub("_component", "")

        "https://primer.style/view-components/lookbook/inspect/#{path}/default/"
      end

      def example_path(component)
        example_path = "../../src/@primer/gatsby-theme-doctocat/components/example"
        example_path = "../#{example_path}" if status_module?(component)
        example_path
      end

      def require_js_path(component)
        require_js_path = "../../src/@primer/gatsby-theme-doctocat/components/requires-js-flash"
        require_js_path = "../#{require_js_path}" if status_module?(component)
        require_js_path
      end

      def preview_exists?(component)
        path = component.name.underscore

        File.exist?("previews/#{path}_preview.rb")
      end

      def status_module?(component)
        (%w[Alpha Beta] & component.name.split("::")).any?
      end

      def parse_example_tag(tag)
        self.class.parse_example_tag(tag)
      end
    end
  end
end