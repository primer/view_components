# frozen_string_literal: true

# :nocov:

require "json"
require "kramdown"

module Primer
  module Static
    # :nodoc:
    module GenerateInfoArch
      SKIP_METHODS = %i[call before_render].freeze

      class << self
        def call
          components = Primer::Component.descendants.sort_by(&:name) - [Primer::BaseComponent]

          component_docs = components.each_with_object({}) do |component, memo|
            docs = registry.find(component)

            preview_data = previews.find do |preview|
              preview["component"] == docs.metadata[:title] &&
                preview["status"] == component.status.to_s
            end

            arg_data = args.find do |component_args|
              component_args["component"] == docs.metadata[:title] &&
                component_args["status"] == component.status.to_s
            end

            slot_docs = docs.slot_methods.map do |slot_method|
              param_tags = slot_method.tags(:param)

              {
                "name" => slot_method.name,
                # rubocop:disable Style/IfUnlessModifier
                "description" =>
                  if slot_method.base_docstring.to_s.present?
                    render_erb_ignoring_markdown_code_fences(slot_method.base_docstring)
                  end,
                # rubocop:enable Style/IfUnlessModifier
                "parameters" => serialize_params(param_tags, component)
              }
            end

            mtds = docs.non_slot_methods.select do |mtd|
              next false if mtd.base_docstring.to_s.blank?
              next false if SKIP_METHODS.include?(mtd.name)

              method_location, = mtd.files.first
              class_location, = docs.docs.files.first

              method_location == class_location
            end

            method_docs = mtds.map do |mtd|
              param_tags = mtd.tags(:param)

              {
                "name" => mtd.name,
                "description" => render_erb_ignoring_markdown_code_fences(mtd.base_docstring),
                "parameters" => serialize_params(param_tags, component)
              }
            end

            description =
              if component == Primer::BaseComponent
                docs.base_docstring
              else
                render_erb_ignoring_markdown_code_fences(docs.base_docstring)
              end

            accessibility_docs =
              if (accessibility_tag_text = docs.tags(:accessibility)&.first&.text)
                render_erb_ignoring_markdown_code_fences(accessibility_tag_text)
              end

            memo[component] = {
              "fully_qualified_name" => component.name,
              "description" => description,
              "accessibility_docs" => accessibility_docs,
              "is_form_component" => docs.manifest_entry.form_component?,
              "is_published" => docs.manifest_entry.published?,
              "requires_js" => docs.manifest_entry.requires_js?,
              **arg_data,
              "slots" => slot_docs,
              "methods" => method_docs,
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

          component_docs.values + [system_args_docs]
        end

        private

        def system_args_docs
          docs = registry.find(Primer::BaseComponent)

          {
            component: "BaseComponent",
            fully_qualified_name: "Primer::BaseComponent",
            description_md: docs.base_docstring,
            args_md: render_erb_ignoring_markdown_code_fences(docs.constructor.base_docstring)
          }
        end

        def serialize_params(param_tags, component)
          param_tags.map do |tag|
            default_value = Primer::Yard::DocsHelper.pretty_default_value(tag, component)

            {
              "name" => tag.name,
              "type" => tag.types&.join(", ") || "",
              "default" => default_value,
              "description" => render_erb_ignoring_markdown_code_fences(tag.text.squish)
            }
          end
        end

        def previews
          @previews ||= JSON.parse(Static.read(:previews))
        end

        def args
          @args ||= Primer::Static::GenerateArguments.call(view_context: view_context)
        end

        def view_context
          @view_context ||= ApplicationController.new.tap { |c| c.request = ActionDispatch::TestRequest.create }.view_context.tap do |vc|
            vc.singleton_class.include(Primer::Yard::InfoArchDocsHelper)
            vc.singleton_class.include(Primer::ViewHelper)
          end
        end

        # Renders ERB code to a string, ignoring markdown code fences. For example, consider the
        # following ERB code inside a markdown document:
        #
        # ### Heading
        # ```erb
        # <%= render(SomeComponent.new) %>
        # ```
        #
        # <%= some_func(a, b) %>
        #
        # The ERB renderer does not understand that the fenced code, i.e. the part inside the triple
        # backticks, should not be rendered. It sees the ERB tags both inside and outside the fence
        # and renders them both.
        #
        # This method renders ERB tags in a markdown string, ignoring any fenced code blocks, so as
        # to prevent rendering fenced ERB code.
        #
        def render_erb_ignoring_markdown_code_fences(markdown_str)
          return view_context.render(inline: markdown_str) unless markdown_str.include?("```")

          # identify all fenced code blocks in markdown string
          code_ranges = find_fenced_code_ranges_in(markdown_str)

          # replace code fences with placeholders
          de_fenced_markdown_str = markdown_str.dup.tap do |memo|
            code_ranges.reverse_each.with_index do |code_range, idx|
              memo[code_range] = "<!--codefence#{idx}-->"
            end
          end

          # Render ERB tags. The only ones left will explicitly exist _outside_ markdown code fences.
          rendered_str = view_context.render(inline: de_fenced_markdown_str)

          # replace placeholders with original code fences
          code_ranges.reverse_each.with_index do |code_range, idx|
            rendered_str.sub!("<!--codefence#{idx}-->", markdown_str[code_range])
          end

          rendered_str
        end

        def find_fenced_code_ranges_in(str)
          doc = Kramdown::Document.new(str)
          line_starts = find_line_starts_in(str)

          [].tap do |code_ranges|
            each_codespan_in(doc.root) do |node|
              options = node.options
              delimiter = options[:codespan_delimiter]
              next unless delimiter.start_with?("```")

              start_pos = line_starts[options[:location]]
              end_pos = start_pos + node.value.size + delimiter.size
              end_pos = str.index("```", end_pos) + 3

              code_ranges << (start_pos...end_pos)
            end
          end
        end

        def find_line_starts_in(str)
          line_counter = 2

          { 1 => 0 }.tap do |memo|
            str.scan(/\r?\n/) do
              memo[line_counter] = Regexp.last_match.end(0)
              line_counter += 1
            end
          end
        end

        def each_codespan_in(node, &block)
          return unless node.respond_to?(:children)

          node.children.each do |child|
            yield child if child.type == :codespan
            each_codespan_in(child, &block)
          end
        end

        def registry
          @registry ||= Primer::Yard::Registry.make
        end
      end
    end
  end
end
