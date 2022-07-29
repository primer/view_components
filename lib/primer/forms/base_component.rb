# frozen_string_literal: true

require "primer/class_name_helper"

module Primer
  module Forms
    # :nodoc:
    class BaseComponent
      include Primer::ClassNameHelper
      extend ActsAsComponent

      def self.inherited(base)
        base.renders_template File.join(__dir__, "#{base.name.demodulize.underscore}.html.erb"), :render_template
      end

      delegate :required?, :disabled?, :hidden?, to: :@input

      def perform_render(&block)
        @__prf_content_block = block
        compile_and_render_template
      end

      def content
        return @__prf_content if defined?(@__prf_content_evaluated) && @__prf_content_evaluated

        @__prf_content_evaluated = true
        @__prf_content = capture do
          @__prf_content_block.call
        end
      end

      def type
        :component
      end

      def input?
        false
      end

      private

      def compile_and_render_template
        self.class.compile! unless self.class.instance_methods(false).include?(:render_template)
        render_template
      end

      def content_tag_if(condition, tag, **kwargs, &block)
        if condition
          content_tag(tag, **kwargs, &block)
        else
          capture(&block)
        end
      end
    end
  end
end
