# frozen_string_literal: true

require "primer/yard/component_manifest"
require "primer/yard/backend"

module Primer
  module YARD
    class LookbookPagesBackend < Backend
      attr_reader :registry

      def initialize(registry)
        @registry = registry
      end

      def generate
        each_component do |component|
          generate_component_docs(component)
        end
      end

      private

      def generate_component_docs(component)
        docs = registry.find(component)
        path = File.join(*%w(demo test components docs forms inputs), "#{docs.short_name.dasherize.underscore}.md.erb")
        id = docs.short_name.dasherize.underscore
        id << "_input" unless id.end_with?("_input")
        documented_methods = docs.non_slot_methods.select do |mtd|
          [component.name, "Primer::Forms::Dsl::InputMethods"].include?(mtd.parent.title)
        end

        File.open(path, "w") do |f|
          f.write(eval(Erubi::Engine.new(<<~ERB, trim: true).src))
            ---
            title: <%= docs.title.underscore.titleize %>
            id: <%= id %>
            ---

            <%= docs.base_docstring %>

            ## Usage

            ```ruby
            <%= docs.tags(:form_usage).first.text %>
            ```

            <% specific_args = specific_args_from(docs.params) %>
            <% unless specific_args.empty? %>
            ## Arguments

            <%= generate_args_table(component, specific_args) %>
            <% end %>

            ## Common arguments

            <%= generate_args_table(component, common_args_from(docs.params)) %>

            <% unless documented_methods.empty? %>
            ## Methods

              <% documented_methods.each do |method_docs| %>
            ### `#<%= method_docs.signature.sub(/def /, "") %>`

            <%= method_docs.base_docstring %>

                <% param_tags = method_docs.tags(:param) %>

                <% if param_tags.any? %>

            <%= generate_args_table(component, param_tags) %>
                <% end %>
              <% end %>
            <% end %>
          ERB
        end
      end

      def generate_args_table(component, params)
        rows = params.map do |tag|
          default_value = pretty_default_value(tag, component)
          description = view_context.render(inline: tag.text.squish)
          parts = [
            "`#{tag.name}`",
            tag.types.join(", "),
            default_value,
            description
          ]

          "| #{parts.join(" | ")} |"
        end

        <<~END
          | Name | Type | Default | Description |
          | :- | :- | :- | :- |
          #{rows.join("\n")}
        END
      end

      def each_component(&block)
        manifest.form_components.each(&block)
      end

      def manifest
        Primer::YARD::ComponentManifest
      end

      def common_args_from(params)
        params.select { |param| common_form_input_argument_names.include?(param.name) }
      end

      def specific_args_from(params)
        params.reject { |param| common_form_input_argument_names.include?(param.name) }
      end

      def common_form_input_argument_names
        @common_form_input_argument_names ||= begin
          macro = registry.yard_registry[".macro.form_input_arguments"]
          parser = ::YARD::Docstring.parser
          parser.parse(macro.macro_data)
          parser.tags
            .select { |tag| tag.tag_name == "param" }
            .map(&:name)
        end
      end
    end
  end
end
