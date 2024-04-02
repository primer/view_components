# frozen_string_literal: true

require "primer/classify"

# See: https://github.com/rails/rails/pull/46666
ActionView::Helpers::Tags::Base.prepend(
  Module.new do
    def initialize(*args, **kwargs, &block)
      super

      return if defined?(@generate_error_markup)

      @generate_error_markup = @options.delete(:generate_error_markup) { true }
    end

    private

    def error_wrapping(html_tag)
      return html_tag unless @generate_error_markup

      # :nocov:
      super
      # :nocov:
    end
  end
)

module Primer
  module Forms
    module Tags
      # :nodoc:
      class TextField < ::ActionView::Helpers::Tags::TextField
        def attributes
          render
        end

        private

        def tag(_name, options)
          options
        end
      end
    end

    # :nodoc:
    class Builder < ActionView::Helpers::FormBuilder
      alias primer_fields_for fields_for

      def label(method, text = nil, **options, &block)
        super(method, text, classify(options).merge(generate_error_markup: false), &block)
      end

      def check_box(method, options = {}, checked_value = 1, unchecked_value = 0, &block)
        super(
          method,
          classify(options).merge(generate_error_markup: false),
          checked_value,
          unchecked_value,
          &block
        )
      end

      def radio_button(*args, **options, &block)
        super(*args, classify(options).merge(generate_error_markup: false), &block)
      end

      def select(method, choices = nil, options = {}, html_options = {}, &block)
        super(method, choices, options.merge(generate_error_markup: false), classify(html_options), &block)
      end

      def text_field(*args, **options, &block)
        super(*args, classify(options).merge(generate_error_markup: false), &block)
      end

      def text_field_attributes(method, options = {})
        Tags::TextField.new(@object_name, method, @template, options).attributes
      end

      def text_area(*args, **options, &block)
        super(*args, classify(options).merge(generate_error_markup: false), &block)
      end

      private

      def classify(options)
        Primer::Forms::Utils.classify(options)
      end
    end
  end
end
