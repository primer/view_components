# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class Base
      extend ActsAsComponent

      renders_template File.join(__dir__, "base.html.erb"), :render_base_form

      class << self
        attr_reader :has_after_content, :__vcf_form_block, :__vcf_builder
        alias after_content? has_after_content

        def form(&block)
          @__vcf_form_block = block
        end

        def new(builder, **options)
          if builder && !builder.is_a?(Primer::Forms::Builder)
            raise ArgumentError, "please pass an instance of Primer::Forms::Builder when "\
              "constructing a form object (consider using the `primer_form_with` helper)"
          end

          allocate.tap do |form|
            form.instance_variable_set(:@builder, builder)
            form.send(:initialize, **options)
          end
        end

        def inherited(base)
          form_path = const_source_location(base.name)
          return unless form_path

          base.template_root_path = File.join(File.dirname(form_path), base.name.demodulize.underscore)

          base.renders_template "after_content.html.erb" do
            base.instance_variable_set(:@has_after_content, true)
          end

          base.renders_templates "*_caption.html.erb" do |path|
            base.fields_with_caption_templates << File.basename(path).chomp("_caption.html.erb").to_sym
          end
        end

        def caption_template?(field_name)
          fields_with_caption_templates.include?(field_name)
        end

        def fields_with_caption_templates
          @fields_with_caption_templates ||= []
        end

        private

        # Unfortunately this bug (https://github.com/ruby/ruby/pull/5646) prevents us from using
        # Ruby's native Module.const_source_location. Instead we have to fudge it by searching
        # for the file in the configured autoload paths. Doing so relies on Rails' autoloading
        # conventions, so it should work ok. Zeitwerk also has this information but lacks a
        # public API to map constants to source files.
        def const_source_location(class_name)
          # NOTE: underscore respects namespacing, i.e. will convert Foo::Bar to foo/bar.
          class_path = "#{class_name.underscore}.rb"

          ActiveSupport::Dependencies.autoload_paths.each do |autoload_path|
            absolute_path = File.join(autoload_path, class_path)
            return absolute_path if File.exist?(absolute_path)
          end

          nil
        end
      end

      def inputs
        @inputs ||= form_object.inputs.map do |input|
          next input unless input.input?

          # wrap inputs in a group (unless they are already groups)
          if input.type == :group
            input
          else
            Primer::Forms::Dsl::InputGroup.new(builder: @builder, form: self) do |group|
              group.send(:add_input, input)
            end
          end
        end
      end

      def each_input_in(root_input, &block)
        return enum_for(__method__, root_input) unless block

        root_input.inputs.each do |input|
          if input.respond_to?(:inputs)
            each_input_in(input, &block)
          else
            yield input
          end
        end
      end

      def before_render
        each_input_in(self) do |input|
          if input.input? && input.invalid? && input.focusable?
            input.autofocus!
            break
          end
        end
      end

      def caption_template?(*args)
        self.class.caption_template?(*args)
      end

      def after_content?(*args)
        self.class.after_content?(*args)
      end

      def render_caption_template(name)
        send(:"render_#{name}_caption")
      end

      def perform_render(&_block)
        Base.compile!
        self.class.compile!

        render_base_form
      end

      private

      def form_object
        # rubocop:disable Naming/MemoizedInstanceVariableName
        @__pf_form_object ||= Primer::Forms::Dsl::FormObject.new(builder: @builder, form: self).tap do |obj|
          # compile before adding inputs so caption templates are identified
          self.class.compile!
          instance_exec(obj, &self.class.__vcf_form_block)
        end
        # rubocop:enable Naming/MemoizedInstanceVariableName
      end
    end
  end
end
