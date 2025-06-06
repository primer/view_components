# frozen_string_literal: true

require "pathname"

module Primer
  module Forms
    # :nodoc:
    module ActsAsComponent
      # :nodoc:
      module InstanceMethods
        delegate :render, :content_tag, :output_buffer, :capture, to: :@view_context

        def render_in(view_context, &block)
          @view_context = view_context
          before_render
          perform_render(&block)
        end

        # :nocov:
        def perform_render(&_block)
          raise NotImplementedError, "subclasses must implement ##{__method__}."
        end
        # :nocov:

        def before_render; end

        # :nocov:
        def set_original_view_context(view_context)
          @view_context = view_context
        end
        # rubocop:enable Naming/AccessorMethodName
        # :nocov:
      end

      def self.extended(base)
        base.include(InstanceMethods)
      end

      TemplateGlob = Struct.new(:glob_pattern, :method_name, :on_compile_callback)
      TemplateParams = Struct.new(:source, :identifier, :type, :format, keyword_init: true)

      def renders_templates(glob_pattern, method_name = nil, &block)
        template_globs << TemplateGlob.new(glob_pattern, method_name, block)
      end
      alias renders_template renders_templates

      def compile!
        # always recompile in dev
        return if defined?(@compiled) && @compiled && !Rails.env.development?

        template_globs.each do |template_glob|
          compile_templates_in(template_glob)
        end

        @compiled = true
      end

      def template_root_path
        return @template_root_path if defined?(@template_root_path)

        form_path = Utils.const_source_location(self.name)
        @template_root_path =
          if form_path
            File.join(File.dirname(form_path), self.name.demodulize.underscore)
          end
      end

      def base_template_path
        return @base_template_path if defined?(@base_template_path)
        base_path = Utils.const_source_location(self.name)

        if base_path
          @base_template_path = File.dirname(base_path)
        end
      end

      private

      def template_globs
        @template_globs ||= []
      end

      def compile_templates_in(template_glob)
        pattern = template_glob.glob_pattern
        pattern = pattern.gsub("%{base_template_path}", base_template_path) if base_template_path
        pattern =
          if Pathname(pattern).absolute?
            pattern
          else
            # skip compilation for anonymous form classes, as in tests
            return unless template_root_path

            File.join(template_root_path, pattern)
          end

        template_paths = Dir.glob(pattern)

        raise "Cannot compile multiple templates with the same method name." if template_paths.size > 1 && template_glob.method_name

        template_paths.each do |template_path|
          method_name = template_glob.method_name
          method_name ||= "render_#{File.basename(template_path).chomp('.html.erb')}"
          define_template_method(template_path, method_name)
          template_glob&.on_compile_callback&.call(template_path)
        end
      end

      def define_template_method(template_path, method_name)
        class_eval <<-RUBY, template_path, 0
        private def #{method_name}
          capture { #{compile_template(template_path)} }
        end
        RUBY
        # rubocop:enable Style/EvalWithLocation
        # rubocop:enable Style/DocumentDynamicEvalDefinition
      end

      def compile_template(path)
        handler = ActionView::Template.handler_for_extension("erb")
        template = File.read(path)
        template_params = TemplateParams.new({
          source: template,
          identifier: __FILE__,
          type: "text/html",
          format: "text/html"
        })

        # change @output_buffer ivar to output_buffer method call
        BufferRewriter.rewrite(
          handler.call(template_params, template)
        )
      end
    end
  end
end
