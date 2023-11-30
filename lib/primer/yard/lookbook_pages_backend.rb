# frozen_string_literal: true

# :nocov:
module Primer
  module Yard
    # A single Lookbook page.
    class LookbookPage
      include DocsHelper

      PREVIEW_MAP = {
        Primer::Alpha::TextField => [:single_text_field_form, :multi_text_field_form],
        Primer::Alpha::TextArea => [],
        Primer::Alpha::Select => [:select_form],
        Primer::Alpha::MultiInput => [:multi_input_form],
        Primer::Alpha::RadioButton => [:radio_button_with_nested_form],
        Primer::Alpha::RadioButtonGroup => [:radio_button_group_form],
        Primer::Alpha::CheckBox => [:check_box_with_nested_form],
        Primer::Alpha::CheckBoxGroup => [:check_box_group_form],
        Primer::Alpha::SubmitButton => [:submit_button_form],
        Primer::Alpha::FormButton => [:submit_button_form]
      }.freeze

      attr_reader :component_ref, :backend, :docs

      def initialize(component_ref, backend, docs)
        @component_ref = component_ref
        @backend = backend
        @docs = docs
      end

      def page_id
        @page_id ||= docs.short_name.dasherize.underscore.tap do |page_id|
          page_id << "_input" unless page_id.end_with?("_input")
        end
      end

      def generate
        path = File.expand_path(
          File.join(
            *%w[.. .. .. previews pages forms inputs],
            "#{docs.short_name.dasherize.underscore}.md.erb"
          ), __dir__
        )

        documented_methods = docs.non_slot_methods.select do |mtd|
          [component.name, "Primer::Forms::Dsl::InputMethods"].include?(mtd.parent.title)
        end

        preview_methods = PREVIEW_MAP[component]
        preview_erbs = preview_methods.map do |preview_method|
          if Primer::FormsPreview.instance_methods.exclude?(preview_method)
            raise "Preview '#{preview_method}' does not exist in Primer::FormsPreview"
          end
          # rubocop:enable Style/IfUnlessModifier

          "<%= embed Primer::FormsPreview, #{preview_method.inspect} %>"
        end
        # rubocop:enable Lint/UselessAssignment

        # rubocop:disable Security/Eval
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

            <%= generate_args_table(specific_args) %>
            <% end %>

            ## Common arguments

            <%= generate_args_table(common_args_from(docs.params)) %>

            <% unless documented_methods.empty? %>
            ## Methods

              <% documented_methods.each do |method_docs| %>
            ### `#<%= method_docs.signature.sub(/def /, "") %>`

            <%= method_docs.base_docstring %>

                <% param_tags = method_docs.tags(:param) %>

                <% if param_tags.any? %>

            <%= generate_args_table(param_tags) %>
                <% end %>
              <% end %>
            <% end %>

            <% unless preview_methods.empty? %>
            ## Examples

            <%= preview_erbs.join("\n") %>
            <% end %>
          ERB
        end
        # rubocop:enable Security/Eval
      end

      private

      def registry
        backend.registry
      end

      def generate_args_table(params)
        rows = params.map do |tag|
          description = backend.view_context.render(inline: tag.text.squish)
          parts = [
            "`#{tag.name}`",
            tag.types.join(", "),
            description
          ]

          "| #{parts.join(' | ')} |"
        end

        <<~MARKDOWN
          | Name | Type | Description |
          | :- | :- | :- |
          #{rows.join("\n")}
        MARKDOWN
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
          parser
            .tags
            .select { |tag| tag.tag_name == "param" }
            .map(&:name)
        end
      end

      def component
        component_ref.klass
      end
    end

    # Backend that generates Lookbook pages.
    class LookbookPagesBackend < Backend
      attr_reader :registry, :manifest

      def initialize(registry, manifest)
        @registry = registry
        @manifest = manifest
      end

      def generate
        each_component do |component_ref|
          page_for(component_ref).generate
        end
        generate_system_args_docs
      end

      def page_for(component_ref)
        docs = registry.find(component_ref.klass)
        LookbookPage.new(component_ref, self, docs)
      end

      def view_context
        @view_context ||= super.tap do |vc|
          vc.singleton_class.include(LookbookDocsHelper)
        end
      end

      private

      def each_component(&block)
        manifest.each(&block)
      end

      def generate_system_args_docs
        docs = registry.find(Primer::BaseComponent)

        path = File.expand_path(
          File.join(
            *%w[.. .. .. previews pages system-arguments.md.erb]
          ), __dir__
        )

        data = {
          "description_md" => docs.base_docstring.to_s,
          "args_md" => view_context.render(inline: docs.constructor.base_docstring)
        }

        frontmatter = {
          "title" => "System arguments",
          "id" => "system_arguments",
          "data" => data
        }

        File.write(
          path, <<~ERB
            #{YAML.dump(frontmatter)}
            ---
            <%= @page.data[:description_md].html_safe %>
            <%= @page.data[:args_md].html_safe %>
          ERB
        )
      end
    end
  end
end
# :nocov:
