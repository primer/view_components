# frozen_string_literal: true

require "primer/yard/component_manifest"
require "primer/yard/backend"
require "primer/yard/lookbook_docs_helper"

module Primer
  module YARD
    class LookbookPage
      include DocsHelper

      PREVIEW_MAP = {
        Primer::Alpha::TextField => [:single_text_field_form, :multi_text_field_form],
        Primer::Alpha::SelectList => [:select_list_form],
        Primer::Alpha::MultiInput => [:multi_input_form],
        Primer::Alpha::RadioButton => [:radio_button_with_nested_form],
        Primer::Alpha::RadioButtonGroup => [:radio_button_group_form],
        Primer::Alpha::CheckBox => [:check_box_with_nested_form],
        Primer::Alpha::CheckBoxGroup => [:check_box_group_form]
      }.freeze

      attr_reader :component, :backend, :docs

      def initialize(component, backend, docs)
        @component = component
        @backend = backend
        @docs = docs
      end

      def page_id
        @id ||= docs.short_name.dasherize.underscore.tap do |id|
          id << "_input" unless id.end_with?("_input")
        end
      end

      def generate
        path = File.join(*%w(demo test components docs forms inputs), "#{docs.short_name.dasherize.underscore}.md.erb")
        documented_methods = docs.non_slot_methods.select do |mtd|
          [component.name, "Primer::Forms::Dsl::InputMethods"].include?(mtd.parent.title)
        end

        preview_methods = PREVIEW_MAP[component]
        preview_erbs = preview_methods.map do |preview_method|
          "<%= embed Primer::Forms::FormsPreview, #{preview_method.inspect} %>"
        end

        File.open(path, "w") do |f|
          f.write(eval(Erubi::Engine.new(<<~ERB, trim: true).src))
            ---
            title: <%= docs.title.underscore.titleize %>
            id: <%= page_id %>
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

            <% unless preview_methods.empty? %>
            ## Examples

            <%= preview_erbs.join("\n") %>
            <% end %>
          ERB
        end
      end

      private

      def registry
        backend.registry
      end

      def generate_args_table(component, params)
        rows = params.map do |tag|
          default_value = pretty_default_value(tag, component)
          description = backend.view_context.render(inline: tag.text.squish)
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

    class LookbookPagesBackend < Backend
      attr_reader :registry

      def initialize(registry)
        @registry = registry
      end

      def generate
        each_component do |component|
          page_for(component).generate
        end
      end

      def page_for(component)
        LookbookPage.new(component, self, registry.find(component))
      end

      def view_context
        @view_context ||= super.tap do |vc|
          vc.singleton_class.include(LookbookDocsHelper)
        end
      end

      private

      def each_component(&block)
        manifest.form_components.each(&block)
      end

      def manifest
        Primer::YARD::ComponentManifest
      end
    end
  end
end
